/// Save our "block" data... Do it quick and simple
/// use "get_save_filename(filter, fname);" to save anywhere.
// This function just creates a buffer with the save data in it.
// map = argument0
var _map=argument0;

with(_map)
{
    var buff = buffer_create(1024*1024*4,buffer_grow,1);

    // Map version
    buffer_write(buff,buffer_u16, 1);
    buffer_write(buff,buffer_u16, MapWidth);
    buffer_write(buff,buffer_u16, MapHeight);
    buffer_write(buff,buffer_u16, MapDepth);
    buffer_write(buff,buffer_u16, SideBase);
    buffer_write(buff,buffer_u16, TopBase);
    buffer_write(buff,buffer_u16, TileSize);
    buffer_write(buff,buffer_u16, TileBorder);
    buffer_write(buff,buffer_u16, PavementTile);
    buffer_write(buff,buffer_u16, GridCacheSize);

    // First copy the RAW map into a stream
    var raw = buffer_create(1024*1024*8,buffer_grow,1);
    for(var yy=0;yy<MapHeight;yy++){
        for(var xx=0;xx<MapHeight;xx++){
            var Arr = ds_grid_get(Map,xx,yy);
            for(var zz=0;zz<MapDepth;zz++){
                buffer_write(raw,buffer_u16,Arr[zz]);
            }
        }
    }

    var size = buffer_tell(raw);
    //CompressBuffer( buff, buffer_tell(raw), raw );
    //buffer_write(buff,buffer_u8, 1);            // set BYTE-RUN compression type

    // in RAW mode, just copy the buffer
    buffer_write(buff,buffer_u8, 0);            // set no compression
    
    // Move to the start, and then just copy, byte for byte....
    buffer_seek(raw,buffer_seek_start,0);
    size =size>>1;
    for(var i=0;i<size;i++){
        var a = buffer_read(raw,buffer_u16);
        buffer_write(buff,buffer_u16,a);
    }

    // Write out number of block info structs we have    
    size = array_length_1d( block_info );
    buffer_write(buff, buffer_u16, size );
    
    // write out info's
    for(var i=0;i<size;i++;){
        var info = block_info[i];
        var len = array_length_1d(info);
        buffer_write(buff,buffer_u8, len);
        buffer_write(buff, buffer_u32, info[0]);
        for(var l=1;l<len;l++){
            buffer_write(buff, buffer_u16, info[l]);
        }
    }
    
        
     // delete temp buffer    
    buffer_delete(raw);
   return buff;
}
