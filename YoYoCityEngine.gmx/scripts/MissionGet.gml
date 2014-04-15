/// MissionGet(chain, index);
//
//*****************************************************************************

var chain, index;
chain = argument0;
index = argument1;

// Scan through the list of missions
var listSize, n, mis;
listSize = ds_list_size(objMissionControl.target);
for (n=0; n<listSize; n++)
    {
    mis = ds_list_find_value(objMissionControl.target, n)
    if (mis[? "chain"] == chain)
    && (mis[? "index"] == index)
        {
        //debug("Found mission that matches given chain + index ("+string(chain)+", "+string(index)+")");
        return mis;
        }
    }

return -1;

