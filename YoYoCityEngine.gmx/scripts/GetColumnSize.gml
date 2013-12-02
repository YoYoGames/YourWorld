/// GetBlockIndex(x,y,z)
//
// return the INDEX of a block at x,y,z
//

var _x=argument0;
var _y=argument1;

if( _x<0 || _x>=oMap.MapWidth  || _y<0 || _y>=oMap.MapHeight) return -1;

// Look up column
var column = ds_grid_get(oMap.Map,_x,_y);

// First, check to see if we need to expand the array to include the requested _Z
return array_length_1d( column );

