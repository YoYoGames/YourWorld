/// Allocate a single cube in the world, and return the block_info index
/// x = argument0
/// y = argument1
/// z = argument2
var _x=argument0;
var _y=argument1;
var _z=argument2;


var column = ds_grid_get(Map,_x,_y);

// First, check to see if we need to expand the array to include the requested _Z
var len = array_length_1d( column );
if( (len-1)<_z ){
    // if we have to expand the array, then the requested block will point to 
    // "cube" 0, which will have more than one ref, so it'll fall through into the 
    // make unique part, and so the array will THEN be written into the grid.
    for(var i=len;i<=_z;i++){
        column[i]=0;           // fill with block "0"
        IncRef(0);
    }
}
var block = column[_z];

// If only THIS block points here, then just modify it directly.
if( RefCount[block]==1 ) return block;

// New block will go on the END of current list
var NewBlock = ds_list_size( block_info );   

// but firstdo we have any "spare" blocks on the free list?
if( ds_stack_size(FreeList)!=0 ){
    NewBlock=ds_stack_pop(FreeList);            // if so, use that first
}
column[_z] = NewBlock;
ds_grid_set(Map,_x,_y,column);


// create a new empty block
var info = 0;
info[BLK_LEFT] = -1;      // left
info[BLK_RIGHT] = -1;      // right
info[BLK_TOP] = -1;      // top
info[BLK_BOTTOM] = -1;      // bottom
info[BLK_LID] = -1;      // lid
info[BLK_BASE] = -1;      // behind (usually hidden)
info[BLK_FLAGS1] =  0;      // block flags (32bits)
info[BLK_FLAGS2] =  0;      // block flags (32bits)
ds_list_add(block_info,info);
AddRef(1);
return NewBlock;

