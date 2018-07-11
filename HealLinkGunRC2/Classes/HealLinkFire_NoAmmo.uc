//============================================================
// HealLinkFire_NoAmmo.uc (Fire mode of the Link Gun Medic, NoAmmo version)
// Credits: 100GPing100(zeluis)
// Copytight zeluis, 2011
// Contact: zeluis.100@gmail.com
//============================================================
class HealLinkFire_NoAmmo extends HealLinkFire;

defaultproperties
{
	AmmoClass=class'HealLinkAmmo_NoAmmo'
	AmmoPerFire=0
	DamageType=class"DamTypeHealLinkShaft"
}