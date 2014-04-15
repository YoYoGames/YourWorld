/// MissionChainStart(name);
//
//  Starts the given mission chain.
//  Fails if it has already been started.
//
//*****************************************************************************

var chain;
chain = objMissionControl.mission[? argument0];
if (chain[? "state"] == 0)
    {
    var mis, index;
    chain[? "state"] = 1;
    index = chain[? "index"];
    mis = MissionGet(argument0, index);
    debug("Chain started ("+string(argument0)+")");
    MissionStart(mis);
    return 1;
    }

return -1;

