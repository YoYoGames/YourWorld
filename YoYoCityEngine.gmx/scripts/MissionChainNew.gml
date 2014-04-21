/// MissionChainNew(name);
//
//  Creates a new ds_map to contain information about the given mision chain.
//  Fails if the chain already exists.
//
//  What the values mean:
//  -- state; Has the chain been started? 0 = NO, 1 = YES, 2 = PROGRESS.
//  -- index; The current mission in the chain.
//
//*****************************************************************************

var _chain;
_chain = argument0;
if (!ds_map_exists(mission, _chain))
    {
    var _newMap;
    _newMap = ds_map_create();
    mission[? _chain] = _newMap;
    _newMap[? "state"] = 0;
    _newMap[? "index"] = 0;
    return _newMap;
    }

// Chain already existed
return -1;

