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
var config bool UseCostumWeaponSlot_Config;
var config int CostumWeaponSlot_Config;


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
	
	class'HealLinkGun.HealLinkFire'.default.HealingDamage = HealDamage_config;
	if ( CostumWeaponSlot_Config == 1 && UseCostumWeaponSlot_Config == True )
		class'HealLinkGun.HealLinkGun'.default.InventoryGroup = 1;
	if ( CostumWeaponSlot_Config == 2 && UseCostumWeaponSlot_Config == True )
		class'HealLinkGun.HealLinkGun'.default.InventoryGroup = 2;
	if ( CostumWeaponSlot_Config == 3 && UseCostumWeaponSlot_Config == True )
		class'HealLinkGun.HealLinkGun'.default.InventoryGroup = 3;
	if ( CostumWeaponSlot_Config == 4 && UseCostumWeaponSlot_Config == True )
		class'HealLinkGun.HealLinkGun'.default.InventoryGroup = 4;
	if ( CostumWeaponSlot_Config == 5 && UseCostumWeaponSlot_Config == True )
		class'HealLinkGun.HealLinkGun'.default.InventoryGroup = 5;
	if ( CostumWeaponSlot_Config == 6 && UseCostumWeaponSlot_Config == True )
		class'HealLinkGun.HealLinkGun'.default.InventoryGroup = 6;
	if ( CostumWeaponSlot_Config == 7 && UseCostumWeaponSlot_Config == True )
		class'HealLinkGun.HealLinkGun'.default.InventoryGroup = 7;
	if ( CostumWeaponSlot_Config == 8 && UseCostumWeaponSlot_Config == True )
		class'HealLinkGun.HealLinkGun'.default.InventoryGroup = 8;
	if ( CostumWeaponSlot_Config == 9 && UseCostumWeaponSlot_Config == True )
		class'HealLinkGun.HealLinkGun'.default.InventoryGroup = 9;
	if ( CostumWeaponSlot_Config == 0 && UseCostumWeaponSlot_Config == True )
		class'HealLinkGun.HealLinkGun'.default.InventoryGroup = 0;
}

static function FillPlayInfo(PlayInfo PlayInfo)
{
	Super.FillPlayInfo(PlayInfo);
	PlayInfo.AddSetting(default.RulesGroup, "HealDamage_config", "Heal Ammount:", 0, 1, "Text", "8;1:15");
	PlayInfo.AddSetting(default.RulesGroup, "StartWithWeapon_config", "Start with Weapon", 0, 1, "Check", "8;1:15");
	PlayInfo.AddSetting(default.RulesGroup, "UseAmmo_config", "Use Ammo", 0, 1, "Check", "8;1:15");
	PlayInfo.AddSetting(default.RulesGroup, "UseCostumWeaponSlot_Config", "Use Costum Weapon Slot", 0, 1, "Check");
	PlayInfo.AddSetting(default.RulesGroup, "CostumWeaponSlot_Config", "Costum Weapon Slot:", 0, 1, "Select", "1;1;2;2;3;3;4;4;5;5;6;6;7;7;8;8;9;9;0;0");
}

static event string GetDescriptionText(String PropName)
{
	if(PropName=="HealDamage_config")
		return "Defines how much the weapon will heal per second (The healing ammount for team mates is not changed by link chains). Default = 10";
	if(PropName=="StartWithWeapon_config")
		return "If set to True players will spawn with the Heal Link Gun, if set to False they will have to pick it up. Default = True";
	if(PropName=="UseAmmo_config")
		return "If set to True the Heal Link Gun will use ammo when firing, if set to False the weapon will have infinit ammo and ammo pickups for this weapon will be removed. Default = False";
	if(PropName=="UseCostumWeaponSlot_Config")
		return "If set to True will use the value set in 'Costum Weapon Slot' fot the slot of the weapon, False will use slot 5. (Default = False)";
	if(PropName=="CostumWeaponSlot_Config")
		return "Slot number for the Heal Link Gun to use. You need to have 'Use Costum Weapon Slot' set to True.";
	else
		return Super.GetDescriptionText(PropName);
}

defaultproperties
{
	GroupName="Link Gun"
	FriendlyName="Heal Link Gun"
	Description="This mutator will provide every player with the Heal Link Gun when they spawn. This weapon does not deals damage, and it's only function is to heal Vehicles, Nodes and Team Mates.||Credits:|Barionyx: for the idea of a link gun that would only heal vehciles and nodes and that would not deal damage.|FewPosts: for the idea for the weapon to also heal team mates.|100GPing100(zeluis): for coding everything up.||This project couldn't be done without the help from the UT2004 community over at the forums(http://forums.epicgames.com/)."

	bAddToServerPackages=True

	HealDamage_config=7
	StartWithWeapon_config=True
	UseAmmo_config=False
}