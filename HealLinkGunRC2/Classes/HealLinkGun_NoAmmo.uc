//============================================================
// HealLinkGun_NoAmmo.uc (Only heals vehicles and node, does not deals damage.
// 					This version, NoAmmo, does not uses Ammo.)
// Credits: 100GPing100(zeluis)
// Copytight zeluis, 2011
// Contact: zeluis.100@gmail.com
//============================================================
class HealLinkGun_NoAmmo extends HealLinkGun;

defaultproperties
{
	FireModeClass(0)=HealLinkFire_NoAmmo
	FireModeClass(1)=HealLinkFire_NoAmmo
	PickupClass=class'HealLinkGunPickup_NoAmmo'
}