/// MissionChainNew(name);
//
//  Creates a new ds_map to contain information about the given mision chain.
//  Fails if the chain already exists.
//
//  What the values mean:
//  -- state; Has the chain been started? 0 = NO, 1 = YES.
//  -- index; The current mission in the chain.
//
//*****************************************************************************

var chain;
chain = argument0;
if (!ds_map_exists(mission, chain))
    {
    var newMap;
    newMap = ds_map_create();
    mission[? chain] = newMap;
    newMap[? "state"] = 0;
    newMap[? "index"] = 0;
    return newMap;
    }

// Chain already existed
return -1;

