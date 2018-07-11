/******************************************************************************
MutUT3Weapons

Creation date: 2008-07-14 12:27
Last change: $Id$
Copyright (c) 2008, Wormbo

NOTE: THIS MUTATOR WAS MODIFIED BY 100GPING100 (zeluis), TO ONNLY REPLACE THE
LINK GUN WITH THE HEAL LINK GUN, AND ITS AMMO AND NOT ALL OTHER WEAPONS AND 
AMMO. THE FILE NAME HAS ALSO BEEN CHANGED AND THE DEFAULT PROPERTIES.

ORIGINAL FILE NAME IS: -MutUT3Weapons.
ORIGINAL DEFAULT PROPERTIES ARE:
defaultproperties
{
     GroupName="Arena"
     FriendlyName="UT3 Weapons"
     Description="Modifies UT2004 weapons so they work similarly to their UT3 counterparts."
}
******************************************************************************/

class MutHealLinkGun extends Mutator;


/**
Modifies pickup bases to spawn the corresponding UT3-style pickups.
*/
function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	local int i;
	local class<Pickup> NewPickupClass;
	local class<Weapon> NewWeaponClass;
	local WeaponLocker Locker;

	if (xWeaponBase(Other) != None) {
		NewWeaponClass = GetReplacementWeapon(xWeaponBase(Other).WeaponType);
		if (NewWeaponClass != None)
			xWeaponBase(Other).WeaponType = NewWeaponClass;
	}
	else if (WildcardBase(Other) != None) {
		// TODO: replace individual powerups
	}
	else if (xPickupBase(Other) != None) {
		NewPickupClass = GetReplacementPickup(xPickupBase(Other).Powerup);
		if (NewPickupClass != None)
			xPickupBase(Other).Powerup = NewPickupClass;
	}
	else if (WeaponLocker(Other) != None) {
		Locker = WeaponLocker(Other);

		for (i = 0; i < Locker.Weapons.Length; ++i) {
			NewWeaponClass = GetReplacementWeapon(Locker.Weapons[i].WeaponClass);
			if (NewWeaponClass != None)
				Locker.Weapons[i].WeaponClass = NewWeaponClass;
		}
	}
	else if (Pickup(Other) != None && Pickup(Other).MyMarker != None) {
		NewPickupClass = GetReplacementPickup(Pickup(Other).Class);
		if (NewPickupClass != None && ReplaceWith(Other, string(NewPickupClass))) {
			return false;
		}
	}
	return Super.CheckReplacement(Other, bSuperRelevant);
}


function string GetInventoryClassOverride(string InventoryClassName)
{
	local class<Weapon> NewWeaponClass;

	NewWeaponClass = GetReplacementWeapon(InventoryClassName);
	if (NewWeaponClass != None) {
		return string(NewWeaponClass);
	}
	return Super.GetInventoryClassOverride(InventoryClassName);
}


function class<Weapon> GetReplacementWeapon(coerce string Original)
{
	if (Right(Original, 6) ~= "Pickup")
		Original = Left(Original, Len(Original) - 6);
	switch (Locs(Original)) {
	case "xweapons.linkgun":
		return class'HealLinkGun';
    default: return none;
	}
}


function class<Pickup> GetReplacementPickup(class<Pickup> Original)
{
	switch (Original) {
	case class'LinkAmmoPickup':
	    return class'HealLinkAmmoPickup';
    default: return none;
	}
}


//=============================================================================
// Default values
//=============================================================================

defaultproperties
{
     GroupName="LinkGun"
     FriendlyName="Heal Link Gun"
     Description="Replaces the Link Gun to a modified one that does not deals damage, only heals vhehicles and nodes.|Credits:|100GPing100 (zeluis): for the weapon coding.|Wormbo: or the mutator coding."
}
