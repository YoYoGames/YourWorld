/// MissionChainDestroy(name);
//
//*****************************************************************************

var chain;
chain = argument0;
show_debug_message(string(chain));
if (ds_map_exists(objMissionControl.mission, chain))
    {
    debug("Killing mission chain: "+string(chain));
    ds_map_delete(objMissionControl.mission, chain);
    
    // test
    ds_list_clear(objMissionControl.target);
    }

return false;

