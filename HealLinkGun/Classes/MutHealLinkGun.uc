//============================================================
// MuHealLinkGun (Mutator for the Heal Link Gun)
// Credits: 100GPing100(zeluis)
// Copytight zeluis, 2011
// Contact: zeluis.100@gmail.com
//============================================================
class MutHealLinkGun extends Mutator;

var config int HealDamage_config;
var config bool StartWithWeapon_config;
var config bool UseAmmo_config;

function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	local int i;
	local WeaponLocker L;

	if (StartWithWeapon_config == True)
	{
		if ( xWeaponBase(Other) != None)
		{
		if ( xWeaponBase(Other).WeaponType == class'xweapons.linkgun' )
			xWeaponBase(Other).WeaponType = None;
		}
		else if ( WeaponPickup(Other) != None )
		{

		}
        
		else if ( WeaponLocker(Other) != None)
		{
			L = WeaponLocker(Other);
			for (i = 0; i < L.Weapons.Length; i++)
				if (L.Weapons[i].WeaponClass == class'LinkGun')
				L.Weapons[i].WeaponClass = None;
		}
		/*if ( (string(Other.Class) == "XWeapons.LinkAmmoPickup") )
		{
		ReplaceWith( Other, "None");
		Other.Destroy();
		return false;
		}*/
		bSuperRelevant = 0;

		if (Other.isA('xPawn'))
		{
			xPawn(Other).RequiredEquipment[2] = "HealLinkGun.HealLinkGun";
		}
	
		return true;
	}
	
	if (StartWithWeapon_config == False)
	{
		if ( xWeaponBase(Other) != None)
		{
		if ( xWeaponBase(Other).WeaponType == class'xweapons.linkgun' )
			xWeaponBase(Other).WeaponType = class'HealLinkGun';
		}
		else if ( WeaponPickup(Other) != None )
		{

		}
        
			else if ( WeaponLocker(Other) != None)
		{
			L = WeaponLocker(Other);
			for (i = 0; i < L.Weapons.Length; i++)
				if (L.Weapons[i].WeaponClass == class'LinkGun')
				L.Weapons[i].WeaponClass = class'HealLinkGun';
		}
		/*if ( (string(Other.Class) == "XWeapons.LinkAmmoPickup") )
		{
		ReplaceWith( Other, "None");
		Other.Destroy();
		return false;
		}*/
		bSuperRelevant = 0;
	
		return true;
	}
	
	if (UseAmmo_config == False)
	{
		if ( (string(Other.Class) == "XWeapons.LinkAmmoPickup") )
		{
		ReplaceWith( Other, "None");
		Other.Destroy();
		return false;
		}
		bSuperRelevant = 0;
	
		return true;
	}
	
	if ( GameReplicationInfo(Other) != None )
	{
	GameReplicationInfo(Other).bFastWeaponSwitching = true;		
	GotoState('');
	}
	return True;
}

simulated function BeginPlay()
{
	Super.BeginPlay();
	
	class'HealLinkGun.HealLinkFire'.default.HealingDamage=HealDamage_config;
}

static function FillPlayInfo(PlayInfo PlayInfo)
{
	Super.FillPlayInfo(PlayInfo);
	PlayInfo.AddSetting(default.RulesGroup, "HealDamage_config", "Heal Ammount:", 0, 1, "Text", "8;1:15");
	PlayInfo.AddSetting(default.RulesGroup, "StartWithWeapon_config", "Start with Weapon", 0, 1, "Check", "8;1:15");
	PlayInfo.AddSetting(default.RulesGroup, "UseAmmo_config", "Use Ammo", 0, 1, "Check", "8;1:15");
}

static event string GetDescriptionText(String PropName)
{
	if(PropName=="HealDamage_config")
		return "Defines how much the weapon will heal per second (The healing ammount for team mates is not changed by link chains). Default = 10";
	if(PropName=="StartWithWeapon_config")
		return "If set to True players will spawn with the Heal Link Gun, if set to False they will have to pick it up. Default = True";
	if(PropName=="UseAmmo_config")
		return "If set to True the Heal Link Gun will use ammo when firing, if set to False the weapon will have infinit ammo and ammo pickups for this weapon will be removed. Default = False";
	else
		return Super.GetDescriptionText(PropName);
}

defaultproperties
{
	GroupName="Link Gun"
	FriendlyName="Heal Link Gun"
	Description="This mutator will provide every player with the Heal Link Gun when they spawn. This weapon does not deals damage, and it's only function is to heal Vehicles, Nodes and Team Mates.||Credits:|Barionyx: for the idea of a link gun that would only heal vehciles and nodes and that would not deal damage.|FewPosts: for the idea for the weapon to also heal team mates.|100GPing100(zeluis): for coding everything up.||This project couldn't be done without the help from the UT2004 community over at the forums(http://forums.epicgames.com/)."

	bAddToServerPackages=True

	HealDamage_config=10
	StartWithWeapon_config=True
	UseAmmo_config=False
}