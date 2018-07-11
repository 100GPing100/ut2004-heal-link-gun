//============================================================
// HealLinkAmmmoPickup_NoAmmo.uc (Ammo pickup class of the Link Gun Medic, NoAmmo version)
// Credits: 100GPing100(zeluis)
// Copytight zeluis, 2011
// Contact: zeluis.100@gmail.com
//============================================================
class HealLinkAmmoPickup_NoAmmo extends HealLinkAmmoPickup;

defaultproperties
{
	InventoryType=class'HealLinkAmmo_NoAmmo'

	PickupMessage="You picked up some heal link charges."

	AmmoAmount=0
	MaxDesireability=0.0
    CollisionHeight=0.000000
//	PickupSound=Sound'PickupSounds.FlakAmmoPickup'
	StaticMesh=StaticMesh'WeaponStaticMesh.FlakAmmoPickup' //To be difrent, for testing purposes.
	DrawScale=0.0
}