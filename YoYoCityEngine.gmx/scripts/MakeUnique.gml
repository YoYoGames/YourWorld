/// MakeUnique(map,x,y,z)
//
// Make a block "unique" so that we can alter faces/tyextures/flags etc and return the block_info index
//
var _map=argument0;
var _x=argument1;
var _y=argument2;
var _z=argument3;

with(_map)
{
    // Get the length of the block list (if we need another one, it goes on the end)
    var column = ds_grid_get(Map,_x,_y);
    
    // First, check to see if we need to expand the array to include the requested _Z
    var len = array_length_1d( column );
    if( (len-1)<_z ){
        // if we have to expand the array, then the requested block will point to 
        // "cube" 0, which will have more than one ref, so it'll fall through into the 
        // make unique part, and so the array will THEN be written into the grid.
        for(var i=len;i<=_z;i++){
            column[i]=0;           // fill with block "0"
            RefCount[0]++;
        }
    }
    
    
    var oldblock = column[_z];
    
    // If only THIS block points here, then just modify it directly.
    if( RefCount[oldblock]==1 ) return oldblock;
    
    // First, do we have any "spare" blocks on the free list?
    var NewBlock = block_info_size;                 //array_length_1d( block_info );
    if( ds_stack_size(FreeList)!=0 ){
        NewBlock=ds_stack_pop(FreeList);            // if so, use that first
    }else{
        // if not free, then we're adding a block
        block_info_size++;
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
}


