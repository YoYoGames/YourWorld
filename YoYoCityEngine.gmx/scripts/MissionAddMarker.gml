/// MissionAddMarker(id, text, color);
//
//*****************************************************************************

var newMarker;
newMarker = ds_map_create();
newMarker[? "id"] = argument0;
newMarker[? "text"] = argument1;
newMarker[? "color"] = argument2;
ds_list_add(objMissionControl.markers, newMarker);
debug("Mission marker added: id ("+string(argument0)+"), text("+string(argument1)+"), color("+string(argument2)+")");

