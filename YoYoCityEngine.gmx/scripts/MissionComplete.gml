/// MissionComplete(mission);
//
//*****************************************************************************

debug("");
debug("Mission Completed!");
debug("********************");

debug("Timer depleted.");
objMissionControl.missionTimer = -1;

var mis, chain, index;
mis = argument0;
chain = mis[? "chain"];
index = mis[? "index"];
MissionChainPlusIndex(chain);
MissionChainSetState(chain, 2);

debug("Mission completed: "+string(chain)+" ("+string(index)+")");
debug("");

// Try and go to the next mission
//var newMission;
//newMission = MissionGet(chain, index+1);
//if (newMission != -1)
    //MissionStart(newMission);

// There is no next mission, end chain
//else
    //{
    //debug("End of mission chain: "+string(chain));
    //MissionChainDestroy(chain);
    //debug("Restting Mission Timer...");
    //objMissionControl.newMissionTimer = 2*room_speed;
    //debug("");
    //}

