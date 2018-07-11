//============================================================
// HealLinkGun (Only heals vehicles and node, does not deals damage)
// Credits: 100GPing100(zeluis)
// Copytight zeluis, 2011
// Contact: zeluis.100@gmail.com
//============================================================
class HealLinkGun extends LinkGun;

simulated event RenderOverlays( Canvas Canvas )
{
	if (((FireMode[1] != None) || (FireMode[0] != None)) && (!FireMode[1].bIsFiring || !FireMode[0].bIsFiring) && (ThirdPersonActor != None) )
	{
		if ( Links > 0 )
			LinkAttachment(ThirdPersonActor).SetLinkColor( LC_Gold );
		else
			LinkAttachment(ThirdPersonActor).SetLinkColor( LC_Green );
	}
	super.RenderOverlays( Canvas );
}

defaultproperties
{
	 ItemName="Heal Link Gun"
	 Description="Brionyx used a difrent weapon set, and he wanted a Link Gun that wouldn't damage, just heal, so he headed to the forums and asked if this existed. After some time 100GPing100 (zeluis) saw the thread and said that he could creat the weapon for him, so this is why this weapon exists."
	 
	 FireModeClass(0)=HealLinkFire
	 FireModeClass(1)=HealLinkFire
	 PickupClass=class'HealLinkGunPickup'
	 InventoryGroup=1
	 
	 AIRating=+0.55
	 CurrentRating=+0.55
}