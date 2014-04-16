/// MissionAdd(missionList, itemList, minimapText, minimapIcon, color, chain, index, startText, endText);
//
//*****************************************************************************

var newMap;
newMap = ds_map_create();
newMap[? "id"]        = argument1;
newMap[? "time"]      = argument2;
newMap[? "text"]      = argument3;
newMap[? "icon"]      = argument4;
newMap[? "color"]     = argument5;
newMap[? "chain"]     = argument6;
newMap[? "index"]     = argument7;
newMap[? "startText"] = argument8;
newMap[? "endText"]   = argument9;
ds_list_add(argument0, newMap);

