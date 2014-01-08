/// GetHasRoad(x, y, z);
//
//

var block, info, flags;

block = MakeUnique(global.Map, argument0, -argument1, argument2);
info  = oMap.block_info[block];
flags = (info[BLK_FLAGS1] >> 22) & $F;
return (flags > 0);

