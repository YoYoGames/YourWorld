/// Allocate a single cube in the world, and return the block_info index
/// x = argument0
/// y = argument1
/// z = argument2
var _x=argument0;
var _y=argument1;
var _z=argument2;


var column = ds_grid_get(Map,_x,_y);
var block = column[_z];

// If only THIS block points here, then just modify it directly.
if( RefCount[block]==1 ) return block;

// New block will go on the END of current list
var NewBlock = array_length_1d( block_info );   

// but firstdo we have any "spare" blocks on the free list?
if( ds_stack_size(FreeList)!=0 ){
    NewBlock=ds_stack_pop(FreeList);            // if so, use that first
}
column[_z] = NewBlock;
ds_grid_set(Map,_x,_y,column);


// create a new empty block
var info = 0;
info[0] =  0;      // block flags (32bits)
info[1] = -1;      // left
info[2] = -1;      // right
info[3] = -1;      // top
info[4] = -1;      // bottom
info[5] = -1;      // lid
info[6] = -1;      // behind (usually hidden)
block_info[NewBlock]=info;
RefCount[NewBlock]=1;
return NewBlock;

