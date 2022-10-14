class ExtendedAnnouncer extends MultiKillMessage;
#exec OBJ LOAD FILE=..\Sounds\ExtendedAnnouncer.uax

var(Messages) localized string MegaKillString;
var(Messages) localized string LudKillString;
var(Messages) localized string HolyshitKillString;

event PostBeginPlay() {
   Super.PostBeginPlay(); 
}

static function string GetString( optional int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject )
{
  switch( Switch )
  {
    case 0:  return "";
       break;
    case 1:  return default.DoubleKillString;
       break;
   case 2:  return default.TripleKillString;
       break;
    case 3:  return default.MultiKillString;
       break;
    case 4:  return default.MegaKillString;
       break;
    case 5:  return default.UltraKillString;
       break;
    case 6: return default.MonsterKillString;
     break;
     case 7: return default.LudKillString;
     break;
    default: return default.HolyshitKillString;
       break;
  }
}

static simulated function ClientReceive( PlayerPawn P, optional int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject )
{
  super( LocalMessagePlus ).ClientReceive( P, Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject );

  switch( Switch )
  {
    case 0:  break;
    case 1:  P.ClientPlaySound( sound'ExtendedAnnouncer.DoubleKill', , true );
       break;
    case 2:  P.ClientPlaySound( sound'ExtendedAnnouncer.TripleKill', , true );
       break;
    case 3:  P.ClientPlaySound( sound'ExtendedAnnouncer.MultiKill', , true );
       break;
    case 4:  P.ClientPlaySound( sound'ExtendedAnnouncer.MegaKill', , true );
       break;
    case 5:  P.ClientPlaySound( sound'ExtendedAnnouncer.UltraKill', , true );
       break;
    case 6:  P.ClientPlaySound( sound'ExtendedAnnouncer.MonsterKill', , true );
       break;
    case 7:  P.ClientPlaySound( sound'ExtendedAnnouncer.ludicrousKill', , true );
       break;
    default: P.ClientPlaySound( sound'ExtendedAnnouncer.holyshit', , true );
       break;
  }
}

defaultproperties
{
    MegaKillString="MEGA KILL!!"
    LudKillString="L U D I C R O U S  K I L L ! ! !"
    HolyshitKillString="H O L Y  S H I T ! ! ! "
}