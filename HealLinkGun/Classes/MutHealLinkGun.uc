//============================================================
// MuHealLinkGun (Mutator that gives the Heal Link Gun to everyone when they spawn)
// Credits: 100GPing100(zeluis)
// Copytight zeluis, 2011
// Contact: zeluis.100@gmail.com
//============================================================
class MutHealLinkGun extends Mutator;

function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	bSuperRelevant = 0;
	
	if (Other.isA('xPawn'))
	{
		xPawn(Other).RequiredEquipment[2] = "HealLinkGun.HealLinkGun";
	}
	
	return true;
}

defaultproperties
{
	GroupName="Heal Link Gun"
	FriendlyName="Heal Link Gun"
	Description="This mutator will make every player to spawn with the Heal Link Gun. This weapon does not deals damage, and it's only function is to heal Vehicles, Nodes and Team Mates.|Credits:|Barionyx: for the idea of a link gun that would only heal vehciles and nodes and that would not deal damage.|FewPosts: for the idea for the weapon to also heal team mates.|100GPing100(zeluis): for coding everything up.||This project couldn't be done without the help from the UT2004 community over at the forums(http://forums.epicgames.com/)."
}