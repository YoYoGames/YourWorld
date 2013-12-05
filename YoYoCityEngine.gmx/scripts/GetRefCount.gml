/// GetRefCount(map, x,y,z)
//
// return number of blocks that point to this, OR if theres a block there at all!
//

var _map=argument0;
var _x=argument1;
var _y=argument2;
var _z=argument3;

if( _x<0 || _x>=_map.MapWidth  || _y<0 || _y>=_map.MapHeight || _z<0 || _z>=_map.MapDepth) return -1;

// Look up column
var column = ds_grid_get(_map.Map,_x,_y);

// First, check to see if we need to expand the array to include the requested _Z
var len = array_length_1d( column );

// If the requested block isn't allocated, return -1 for not used
if( (len-1)<_z ) return -1;

// otherwise, get the block info index
var block = column[_z];

// return the block info
return _map.RefCount[block];


