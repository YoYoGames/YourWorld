/// Save our "block" data... Do it quick and simple
/// use "get_save_filename(filter, fname);" to save anywhere.
// This function just creates a buffer with the save data in it.
// map = argument0
// buffer = argument1

var _map = argument0;
var _buff = argument1;

with(_map)
{
    show_debug_message("Free Map");
    FreeMap();
    show_debug_message("Process File");
    var version = buffer_read(_buff,buffer_u32);
    buffer_read(_buff,buffer_u32);
    buffer_read(_buff,buffer_u32);
    buffer_read(_buff,buffer_u32);
    buffer_read(_buff,buffer_u32);
    buffer_read(_buff,buffer_u32);
    buffer_read(_buff,buffer_u32);
    buffer_read(_buff,buffer_u32);
    buffer_read(_buff,buffer_u32);    
    
    MapWidth = buffer_read(_buff,buffer_u16);
    MapHeight = buffer_read(_buff,buffer_u16);
    MapDepth = buffer_read(_buff,buffer_u16);
    SideBase = buffer_read(_buff,buffer_u16);
    TopBase = buffer_read(_buff,buffer_u16);
    TileSize = buffer_read(_buff,buffer_u16);
    TileBorder = buffer_read(_buff,buffer_u16);
    PavementTile = buffer_read(_buff,buffer_u16);
    GridCacheSize = buffer_read(_buff,buffer_u16);

    var compression = buffer_write(_buff,buffer_u8, 0); 
    
    Cache = ds_grid_create(MapWidth,MapHeight);             // Mesh cache
    Map = ds_grid_create(MapWidth,MapHeight);               // actual grid of arrays used for the map
    FreeList = ds_stack_create();                           // create a new block_info free list

    show_debug_message("Create Grid");
    
    // For uncompressed, we simply read the steam into the map...
    for(var yy=0;yy<MapHeight;yy++)
    {
        for(var xx=0;xx<MapHeight;xx++)
        {
            var Arr = 0;
            var cnt = buffer_read(_buff,buffer_u16);         // get length of array
            for(var zz=0;zz<cnt;zz++){
                Arr[zz] = buffer_read(_buff,buffer_u32);
                /*if( Arr[zz]>32000 ){
                    show_debug_message("err: "+Hex(Arr[zz]));
                }*/
            }
            ds_grid_set(Map,xx,yy,Arr);
        }
    }
    

    // Read the number of block info structs we have    
    var len = buffer_read( _buff, buffer_u32 );
    show_debug_message("Load Block Infos: "+string(len));
    block_info=ds_list_create();

    // reset refcount array
    RefCount = ds_list_create();
        
    
    // read in info's
    for(var i=0;i<len;i++;){
        // reset array
        var info = 0;   
        for(var l=0;l<BLK_FLAGS1;l++){
            info[l] = buffer_read(_buff, buffer_u16);
            if( info[l]==$ffff )  info[l]=-1;
        }
        info[BLK_FLAGS1] = buffer_read(_buff, buffer_u32);
        info[BLK_FLAGS2] = buffer_read(_buff, buffer_u32);
        ds_list_add(block_info,info);
        ds_list_add(RefCount,0);
    }
    IncRef(0);      // block 0 and 1 (empty+pavement) are special. 
    IncRef(1);      // Keep them always

        

  
    show_debug_message("Calc Refs");
    
    // Work out ref counts...
    for(var yy=0;yy<MapHeight;yy++)
    {
        for(var xx=0;xx<MapHeight;xx++)
        {
            var Arr = ds_grid_get(Map,xx,yy);
            var len = array_length_1d(Arr);
            for(var zz=0;zz<len;zz++){
                var a = Arr[zz];
                IncRef(a);                          // might be too slow now. Might need to save these out.
            }
            ds_grid_set(Map,xx,yy,Arr);
        }
    }    

        
    // Now recreate the free list
    var len=ds_list_size(RefCount);
    show_debug_message("Build Free list (infos allocated: "+string(len)+")");
    for(var xx=0;xx<len;xx++){
        if( GetRef(xx)==0 ) {
            show_debug_message("free="+string(xx));
            ds_stack_push(FreeList,xx);
        }
    }
    
    show_debug_message("done");
}





