/// Save our "block" data... Do it quick and simple
/// use "get_save_filename(filter, fname);" to save anywhere.
// This function just creates a buffer with the save data in it.
// map = argument0
// buffer = argument1

var _map = argument0;
var _buff = argument1;

with(_map)
{
    //FreeMap();
    var version = buffer_read(_buff,buffer_u16);
    
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

    
    // For uncompressed, we simply read the steam into the map...
    for(var yy=0;yy<MapHeight;yy++)
    {
        for(var xx=0;xx<MapHeight;xx++)
        {
            var Arr = 0;
            for(var zz=0;zz<MapDepth;zz++){
                Arr[zz] = buffer_read(_buff,buffer_u16);
            }
            ds_grid_set(Map,xx,yy,Arr);
        }
    }
    
    // Read the number of block info structs we have    
    var len = buffer_read( _buff, buffer_u16 );
    block_info=0;

    // reset refcount array
    RefCount = 0;
    RefCount[0]=0;    

        
    
    // read in info's
    for(var i=0;i<len;i++;){
        // reset array
        var info = 0;   
        var sz = buffer_read(_buff,buffer_u8);
        info[0] = buffer_read(_buff, buffer_u32);
        for(var l=1;l<sz;l++){
            info[l] = buffer_read(_buff, buffer_u16);
        }
        block_info[i]=info;
        RefCount[i]=0;
    }
        

  
    
    // Work out ref counts...
    for(var yy=0;yy<MapHeight;yy++)
    {
        for(var xx=0;xx<MapHeight;xx++)
        {
            var Arr = ds_grid_get(Map,xx,yy);
            for(var zz=0;zz<MapDepth;zz++){
                var a = Arr[zz];
                RefCount[a]++;
            }
            ds_grid_set(Map,xx,yy,Arr);
        }
    }    
}





