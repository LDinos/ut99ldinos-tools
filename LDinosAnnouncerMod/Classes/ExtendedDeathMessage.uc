class ExtendedDeathMessage extends DeathMessagePlus;

static function ClientReceive (PlayerPawn P, optional int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject)
{
  local string MultiStr;

  if ( RelatedPRI_1 == P.PlayerReplicationInfo )
  {
    if ( TournamentPlayer(P).myHUD != None )
    {
      TournamentPlayer(P).myHUD.LocalizedMessage(Default.ChildMessage,Switch,RelatedPRI_1,RelatedPRI_2,OptionalObject);
      TournamentPlayer(P).myHUD.LocalizedMessage(Default.Class,Switch,RelatedPRI_1,RelatedPRI_2,OptionalObject);
    }
    if ( Default.bIsConsoleMessage )
    {
      TournamentPlayer(P).Player.Console.AddString(GetString(Switch,RelatedPRI_1,RelatedPRI_2,OptionalObject));
    }
    if ( (RelatedPRI_1 != RelatedPRI_2) && (RelatedPRI_2 != None) )
    {
      if ( (TournamentPlayer(P).Level.TimeSeconds - TournamentPlayer(P).LastKillTime < 3) && (Switch != 1) )
      {
        TournamentPlayer(P).MultiLevel++;
        TournamentPlayer(P).ReceiveLocalizedMessage(Class'ExtendedAnnouncer',TournamentPlayer(P).MultiLevel,RelatedPRI_1);
      } else {
        TournamentPlayer(P).MultiLevel = 0;
      }
      TournamentPlayer(P).LastKillTime = TournamentPlayer(P).Level.TimeSeconds;
    } else {
      TournamentPlayer(P).MultiLevel = 0;
    }
    if ( ChallengeHUD(P.myHUD) != None )
    {
      ChallengeHUD(P.myHUD).ScoreTime = TournamentPlayer(P).Level.TimeSeconds;
    }
  } else {
    if ( RelatedPRI_2 == P.PlayerReplicationInfo )
    {
      TournamentPlayer(P).ReceiveLocalizedMessage(Class'VictimMessage',0,RelatedPRI_1);
      Super(LocalMessage).ClientReceive(P,Switch,RelatedPRI_1,RelatedPRI_2,OptionalObject);
    } else {
      Super(LocalMessage).ClientReceive(P,Switch,RelatedPRI_1,RelatedPRI_2,OptionalObject);
    }
  }
}