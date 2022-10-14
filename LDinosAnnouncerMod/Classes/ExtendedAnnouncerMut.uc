class ExtendedAnnouncerMut extends Mutator;

event PostBeginPlay()
{
    Level.Game.DeathMessageClass = Class'ExtendedDeathMessage';
    log("Extended Announcer mode initialized");
}
