/// MissionRemoveMarker(id);
//
//*****************************************************************************

var size, index, map, markerList;
markerList = objMissionControl.markers;
size = ds_list_size(markerList);
for (index=0; index<size; index++)
    {
    // Find marker and remove, is possible
    map = ds_list_find_value(markerList, index);
    if (ds_map_find_value(map, "id"))
        {
        ds_map_destroy(map);
        ds_list_delete(markerList, index);
        return true;
        }
    }

// Marker did not exist
return false;

