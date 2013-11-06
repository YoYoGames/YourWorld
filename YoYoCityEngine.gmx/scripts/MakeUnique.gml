/// Make a block "unique" so that we can alter faces/tyextures/flags etc and return the block_info index
/// x = argument0
/// y = argument1
/// z = argument2
var _x=argument0;
var _y=argument1;
var _z=argument2;

// Get the length of the block list (if we need another one, it goes on the end)
var column = ds_grid_get(Map,_x,_y);
var oldblock = column[_z];

// If only THIS block points here, then just modify it directly.
if( RefCount[oldblock]==1 ) return oldblock;

// First, do we have any "spare" blocks on the free list?
var NewBlock = array_length_1d( block_info );
if( ds_stack_size(FreeList)!=0 ){
    NewBlock=ds_stack_pop(FreeList);            // if so, use that first
}
column[_z] = NewBlock;
ds_grid_set(Map,_x,_y,column);

// Copy all the details of the OLD block
var info = 0;
OldInfo = block_info[oldblock];
var size = array_length_1d(OldInfo);
for(var i=0;i<size;i++){
    info[i]=OldInfo[i];    
}
block_info[NewBlock]=info;
RefCount[NewBlock]=1;
return NewBlock;

