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
	
	AmmoAmount=50
	
	CollisionHeight=8.250000

    StaticMesh=StaticMesh'WeaponStaticMesh.FlakAmmoPickup'
    DrawType=DT_StaticMesh
    DrawScale=+0.8
    PrePivot=(Z=+6.5)
}