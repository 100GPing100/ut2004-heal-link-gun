//============================================================
// HealLinkAmmmo_NoAmmo.uc (Ammo of the Link Gun Medic, NoAmmo version)
// Credits: 100GPing100(zeluis)
// Copytight zeluis, 2011
// Contact: zeluis.100@gmail.com
//============================================================
class HealLinkAmmo_NoAmmo extends HealLinkAmmo;

defaultproperties
{
	ItemName="Heal Link Gun Ammo"

	PickupClass=class'HealLinkAmmoPickup_NoAmmo'

	MaxAmmo=1
	InitialAmount=1
}