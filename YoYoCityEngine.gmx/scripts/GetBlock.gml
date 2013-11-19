/// GetBlock(x,y,z)
//
// return the block_info
//

var _x=argument0;
var _y=argument1;
var _z=argument2;

if( _x<0 || _x>=MapWidth  || _y<0 || _y>=MapHeight || _z<0 || _z>=MapDepth) return -1;

// Look up column
var column = ds_grid_get(Map,_x,_y);

// First, check to see if we need to expand the array to include the requested _Z
var len = array_length_1d( column );

// If the requested block isn't allocated, return -1 for not used
if( (len-1)<_z ) return -1;

// otherwise, get the block info index
var block = column[_z];

// return the block info
return block_info[block];


