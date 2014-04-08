/// GetHasPavement(x, y, z);
//
//  Returns TRUE if there is a pavement flag in the given cell.
//
//*****************************************************************************

var block, info, flag;

block = MakeUnique(global.Map, argument0, -argument1, argument2);
info  = oMap.block_info[block];
flag = (info[BLK_FLAGS1] >> 26) & $1;
return (flag > 0);
