//============================================================
// HealLinkGunRC2.uc (Only heals vehicles and node, does not deals damage)
// Credits: 100GPing100(zeluis)
// Copytight zeluis, 2011
// Contact: zeluis.100@gmail.com
//============================================================
class HealLinkGun extends LinkGun;

simulated function UpdateLinkColor( LinkAttachment.ELinkColor Color )
{
	if ( FireMode[1] != None || FireMode[0] != None)
		LinkFire(FireMode[1]).UpdateLinkColor( Color );
		LinkFire(FireMode[0]).UpdateLinkColor( Color );

	if ( Mesh == OldMesh )	// no support for old mesh
		return;

	switch ( Color )
	{
		case LC_Green	:	Skins[0] = material'LinkgunShader';
							Skins[1] = material'PowerPulseShader';
							break;
		case LC_Red		: 	Skins[0] = material'LinkgunRedShader';
							Skins[1] = material'PowerPulseShaderRed';
							break;
		case LC_Blue	: 	Skins[0] = material'LinkgunBlueShader';
							Skins[1] = material'PowerPulseShaderBlue';
							break;
		case LC_Gold	:	Skins[0] = material'LinkgunYellowShader';
							Skins[1] = material'PowerPulseShaderYellow';
							break;
	}
}

// AI Interface.
function byte BestMode()
{
	local bot B;
	local Vehicle V;

	B = Bot(Instigator.Controller);
	if ( B == None )
		return 1; // return 0;

	if ( ( (DestroyableObjective(B.Squad.SquadObjective) != None && B.Squad.SquadObjective.TeamLink(B.GetTeamNum()))
		|| (B.Squad.SquadObjective == None && DestroyableObjective(B.Target) != None && B.Target.TeamLink(B.GetTeamNum())) )
	     && VSize(B.Squad.SquadObjective.Location - B.Pawn.Location) < FireMode[1].MaxRange() && (B.Enemy == None || !B.EnemyVisible()) )
		return 1;
	if ( FocusOnLeader(B.Focus == B.Squad.SquadLeader.Pawn) )
		return 1;

	V = B.Squad.GetLinkVehicle(B);
	if ( V == None )
		V = Vehicle(B.MoveTarget);
	if ( V == B.Target )
		return 1;
	if ( (V != None) && (VSize(Instigator.Location - V.Location) < LinkFire(FireMode[1]).TraceRange)
		&& (V.Health < V.HealthMax) && (V.LinkHealMult > 0) && B.LineOfSightTo(V) )
		return 1;
	return 1;
}

function float GetAIRating()
{
	local Bot B;
	local DestroyableObjective O;
	local Vehicle V;
	
	B = Bot(Instigator.Controller);
	if ( B == None )
		return AIRating;
		
	if ( (PlayerController(B.Squad.SquadLeader) != None)
		&& (B.Squad.SquadLeader.Pawn != None)
		&& (LinkGun(B.Squad.SquadLeader.Pawn.Weapon) != None) )
		return 1.2;

	V = B.Squad.GetLinkVehicle(B);
	if ( (V != None)
		&& (VSize(Instigator.Location - V.Location) < 1.5 * LinkFire(FireMode[1]).TraceRange)
		&& (V.Health < V.HealthMax) && (V.LinkHealMult > 0) )
		return 1.2;

	if ( Vehicle(B.RouteGoal) != None && B.Enemy == None && VSize(Instigator.Location - B.RouteGoal.Location) < 1.5 * LinkFire(FireMode[1]).TraceRange
	     && Vehicle(B.RouteGoal).TeamLink(B.GetTeamNum()) )
		return 1.2;

	O = DestroyableObjective(B.Squad.SquadObjective);
	if ( O != None && B.Enemy == None && O.TeamLink(B.GetTeamNum()) && O.Health < O.DamageCapacity
	     && VSize(Instigator.Location - O.Location) < 1.1 * LinkFire(FireMode[1]).TraceRange && B.LineOfSightTo(O) )
		return 1.2;
		
	if ( B.LineOfSightTo(B.Enemy) && (VSize(Instigator.Location - B.Enemy.Location) < 1.1 * LinkFire(FireMode[1]).TraceRange ||
		 VSize(Instigator.Location - B.Enemy.Location) > 1.1 * LinkFire(FireMode[1]).TraceRange) )
		return 0.0; // make it 0.0 so bots do not use this weapon against enemies.
	
	// next if may need to be fixed, since I don't see many bots using the weapon to heal their nodes.
	if ( B.LineOfSightTo(O) && (VSize(Instigator.Location - O.Location) < 1.1 * LinkFire(FireMode[1]).TraceRange || 
		 VSize(Instigator.Location - O.Location) > 1.1 * LinkFire(FireMode[1]).TraceRange))
		return 0.0; // make it 0.0 so bots do not use this weapon against enemie nodes.

	return AIRating * FMin(Pawn(Owner).DamageScaling, 1.5);
}

function bool FocusOnLeader(bool bLeaderFiring)
{
	local Bot B;
	local Pawn LeaderPawn;
	local Actor Other;
	local vector HitLocation, HitNormal, StartTrace;
	local Vehicle V;

	B = Bot(Instigator.Controller);
	if ( B == None )
		return false;
	if ( PlayerController(B.Squad.SquadLeader) != None )
		LeaderPawn = B.Squad.SquadLeader.Pawn;
	else
	{
		V = B.Squad.GetLinkVehicle(B);
		if ( V != None )
		{
			LeaderPawn = V;
			bLeaderFiring = (LeaderPawn.Health < LeaderPawn.HealthMax) && (V.LinkHealMult > 0)
							&& ((B.Enemy == None) || V.bKeyVehicle);
		}
	}
	if ( LeaderPawn == None )
	{
		LeaderPawn = B.Squad.SquadLeader.Pawn;
		if ( LeaderPawn == None )
			return false;
	}
	if ( !bLeaderFiring && (LeaderPawn.Weapon == None || !LeaderPawn.Weapon.IsFiring()) )
		return false;
	if ( (Vehicle(LeaderPawn) != None)
		|| ((LinkGun(LeaderPawn.Weapon) != None) && ((vector(B.Squad.SquadLeader.Rotation) dot Normal(Instigator.Location - LeaderPawn.Location)) < 0.9)) )
	{
		StartTrace = Instigator.Location + Instigator.EyePosition();
		if ( VSize(LeaderPawn.Location - StartTrace) < LinkFire(FireMode[1]).TraceRange )
		{
			Other = Trace(HitLocation, HitNormal, LeaderPawn.Location, StartTrace, true);
			if ( Other == LeaderPawn )
			{
				B.Focus = Other;
				return true;
			}
		}
	}
	return false;
}

function float SuggestAttackStyle()
{
	return 0.0; // set to 0.0 so bots don't use this weapon to attack.
}

defaultproperties
{
	ItemName="Heal Link Gun"
	Description="Brionyx used a difrent weapon set, and he wanted a Link Gun that wouldn't damage, just heal, so he headed to the forums and asked if this existed. After some time 100GPing100 (zeluis) saw the thread and said that he could create the weapon for him. After the first realease FewPosts happeared on the forums and sugested us to make the weapon heal team mates too, we accepted and that is why this weapon exists."

	FireModeClass(0)=HealLinkFire
	FireModeClass(1)=HealLinkFire
	PickupClass=class'HealLinkGunPickup'
	InventoryGroup=5

	AIRating=+0.50
	CurrentRating=+0.50

	Priority=2
}