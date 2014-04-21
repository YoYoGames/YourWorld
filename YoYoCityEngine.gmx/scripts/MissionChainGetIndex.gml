/// MissionChainGetIndex(name);
//
//*****************************************************************************

var chain;
chain = objMissionControl.mission[? argument0];
var get;
get = chain[? "index"];
debug("Found chain index: "+string(get));
return get;

