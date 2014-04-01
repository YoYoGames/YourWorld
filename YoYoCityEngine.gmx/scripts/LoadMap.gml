/// LoadBuffer(map,buffer)
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
    debug("Map version: "+string(version));
    
    // Expansion
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
    TopBase = 82;
    TileSize = buffer_read(_buff,buffer_u16);
    TileBorder = buffer_read(_buff,buffer_u16);
    PavementTile = buffer_read(_buff,buffer_u16);
    GridCacheSize = buffer_read(_buff,buffer_u16);
    CacheWidth = floor((MapWidth+GridCacheSize-1)/GridCacheSize);
    CacheHeight = floor((MapHeight+GridCacheSize-1)/GridCacheSize);

    var compression = buffer_write(_buff,buffer_u8, 0); 
        
    Cache = ds_grid_create(MapWidth,MapHeight);             // Mesh cache
    Map = ds_grid_create(MapWidth,MapHeight);               // actual grid of arrays used for the map
    Sprites = ds_grid_create(MapWidth,MapHeight);           // actual grid of arrays used for sprites in the map
    FreeList = ds_stack_create();                           // create a new block_info free list

    // Used during rendering
    RenderList = 0;
    RenderList[0]=0;
    
    
    show_debug_message("Create Grid");
    var sprite_count=0;
    // For uncompressed, we simply read the steam into the map...
    for(var yy=0;yy<MapHeight;yy++)
    {
        for(var xx=0;xx<MapWidth;xx++)
        {
            var Arr = 0;
            var cnt = buffer_read(_buff,buffer_u16);         // get length of array
            var sprites = cnt&$8000;
            cnt &= $7fff;
            for(var zz=0;zz<cnt;zz++){
                var b = buffer_read(_buff,buffer_u16)&$ffff;
                b |= buffer_read(_buff,buffer_u8)<<16;
                Arr[zz] = b;
            }
            ds_grid_set(Map,xx,yy,Arr);
            
            
            if( sprites ){
                var sz= buffer_read(_buff,buffer_u16);
                var spr=0;
                for(i=0;i<sz;i++){
                    var singlespr = 0;
                    singlespr[0] = buffer_read(_buff,buffer_u16);           // sprite type
                    singlespr[1] = buffer_read(_buff,buffer_u32);           // xyz
                    singlespr[2] = buffer_read(_buff,buffer_u32);           // other
                    spr[i]=singlespr;
                    sprite_count++;
                }
                ds_grid_set(Sprites,xx,yy,spr);            
            }
        }
    }
    debug("Sprites="+string(sprite_count));
    // Read the number of block info structs we have    
    block_info_size = buffer_read( _buff, buffer_u32 );
    block_info=0;
    show_debug_message("Load Block Infos: "+string(block_info_size));


    // reset refcount array
    RefCount = 0;
    RefCount[0]=0;
        
    
    // read in info's
    for(var i=0;i<block_info_size;i++;){
        // reset array
        var info = 0;   
        for(var l=0;l<BLK_FLAGS1;l++){
            info[l] = buffer_read(_buff, buffer_u16);
            if( info[l]==$ffff ) info[l]=-1;
        }
        info[BLK_FLAGS1] = buffer_read(_buff, buffer_u32);
        info[BLK_FLAGS2]=0;
        info[BLK_OFFSETS1] = 0;
        info[BLK_OFFSETS2] = 0;
        info[BLK_OFFSETS3] = 0;
        
        
        if( version<=3 ){
            info[BLK_FLAGS2] = buffer_read(_buff, buffer_u32);
        }
        
        // in higher version numbers, we only read extended info IF we have it.  (if not all 0)
        if(version>3){
            if( (info[BLK_FLAGS1]&$80000000)!=0){
                //debug("extended: "+string(i));
                info[BLK_FLAGS2] = buffer_read(_buff, buffer_u32);
                info[BLK_OFFSETS1] = buffer_read(_buff, buffer_u32);
                info[BLK_OFFSETS2] = buffer_read(_buff, buffer_u32);
                info[BLK_OFFSETS3] = buffer_read(_buff, buffer_u32);
            }
        }
        
        block_info[i]=info;
        RefCount[i]=0;
    }
    // Make sure they have at least 1 ref
    RefCount[0]++;    
    RefCount[1]++;    
    RefCount[2]++;
    
    
    //-------------------------------------------------------------------------
    // OBJECTS
    //
    // 32 bits: Number of objects
    // List of 32 bits:
    // t = type
    // r = rotation
    // x, y, z = position
    // - = spare
    // tttt tttt ---- ---- rrrr rr-- zzzz zzzz
    // yyyy yyyy yyyy yyyy xxxx xxxx xxxx xxxx
    //
    
    var numberOfObjects, n, p, object, xPos, yPos, zPos, rotation, type;
        
    // Get number of objects to load
    numberOfObjects = buffer_read(_buff, buffer_u32);
    show_debug_message(string(numberOfObjects));
    
    // Go through all Objects and sqeeze the info together, then write to buffer
    for (n=0; n<numberOfObjects; n++)
        {
        final1 = buffer_read(_buff, buffer_u32);
        final2 = buffer_read(_buff, buffer_u32);
        
        type = (final1>>24) & $FF;
        xPos = (final2) & $FFFF;
        yPos = (final2>>16) & $FFFF;
        zPos = (final1) & $FF;
        rotation = (final1>>10) & $3F;
        
        newObject = instance_create(xPos, -yPos, ObjectGetIndex(type));
        with (newObject)
            {
            z = zPos*64+8;
            zstart = z;
            phy_rotation = rotation*64;
            ObjectHide();
            respawnTimer = 1;
            }
        
        show_debug_message("        "+string(final1));
        show_debug_message("        "+string(final2));
        show_debug_message("type = "+string(type));
        show_debug_message("x = "+string(floor(xPos)));
        show_debug_message("y = "+string(floor(-yPos)));
        show_debug_message("z = "+string(floor(newObject.z)));
        show_debug_message("rotation = "+string(rotation));
        }

  
    show_debug_message("Calc Refs");
    
    // Work out ref counts...
    for(var yy=0;yy<MapHeight;yy++)
    {
        for(var xx=0;xx<MapHeight;xx++)
        {
            var Arr = ds_grid_get(Map,xx,yy);
            var l = array_length_1d(Arr);
            for(var zz=0;zz<l;zz++){
                var a = Arr[zz];
                if( a>block_info_size ){
                    show_debug_message("a="+string(a));
                }
                RefCount[a]++;
            }
            ds_grid_set(Map,xx,yy,Arr);
        }
    }    

        
    // Now recreate the free list
    show_debug_message("Build Free list");
    for(var xx=0;xx<block_info_size;xx++){
        if( RefCount[xx]==0 ) {
            //show_debug_message("free="+string(xx));
            ds_stack_push(FreeList,xx);
        }
    }
    
    show_debug_message("done");
}





