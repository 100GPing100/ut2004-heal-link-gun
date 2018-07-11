//============================================================
// HealLinkAmmmoPickup.uc (Ammo pickup class of the Link Gun Medic)
// Credits: 100GPing100(zeluis)
// Copytight zeluis, 2011
// Contact: zeluis.100@gmail.com
//============================================================
class HealLinkAmmoPickup extends LinkAmmoPickup;

defaultproperties
{
	 InventoryType=class'HealLinkAmmo'
	 
	 PickupMessage="You picked up some heal link charges."
	 
	 AmmoAmount=0
}