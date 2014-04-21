/// MissionStart(mission);
//
//*****************************************************************************

debug("");
debug("Starting Mission...")
debug("********************");

var mis;
mis = argument0;
debug("Mission ID: "+string(mis));


// Get information about the object that should be placed for this mission
var list, xPos, yPos, zPos, objectIndex;
list = mis[? "id"];
xPos = ds_list_find_value(list, 0);
yPos = ds_list_find_value(list, 1);
zPos = ds_list_find_value(list, 2);
objectIndex = ds_list_find_value(list, 3);

// Place the object
var newInst;
newInst = instance_create(xPos, yPos, objectIndex);
newInst.mission = mis;
MissionAddMarker(newInst, mis[? "text"], mis[? "color"]);
debug("New "+string(object_get_name(objectIndex))+" created at ("+string(xPos)+", "+string(yPos)+", "+string(zPos)+")");

// Timer
objMissionControl.missionTimer = mis[? "time"];
MissionChainSetState(mis[? "chain"], 1);

// Show notification
MissionNotification(mis[? "startText"]);


debug("Mission Started: "+string(mis[? "chain"])+" ("+string(mis[? "index"])+")");
debug("");

