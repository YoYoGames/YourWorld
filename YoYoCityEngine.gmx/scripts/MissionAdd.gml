/// MissionAdd(missionList, itemList, minimapText, minimapIcon, color, chain, index, startText, endText);
//
//*****************************************************************************

var newMap;
newMap = ds_map_create();
newMap[? "id"]        = argument1;
newMap[? "text"]      = argument2;
newMap[? "icon"]      = argument3;
newMap[? "color"]     = argument4;
newMap[? "chain"]     = argument5;
newMap[? "index"]     = argument6;
newMap[? "startText"] = argument7;
newMap[? "endText"]   = argument8;
ds_list_add(argument0, newMap);

