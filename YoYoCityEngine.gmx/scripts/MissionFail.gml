/// MissionFail(mission);
//
//*****************************************************************************

debug("");
debug("Mission Failed!");
debug("********************");

MissionChainDestroy("testChain");
MissionNotification("Mission Failed!");

with (parMissionTarget)
    {
    MissionRemoveMarker(id);
    instance_destroy();
    }

objMissionControl.missionTimer = -1;
objMissionControl.newMissionTimer = 2*room_speed;

debug("");

