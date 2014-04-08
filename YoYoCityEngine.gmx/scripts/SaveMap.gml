/// buffer = SaveMap(map, flags);
//
/// Save our "block" data... Do it quick and simple
/// use "get_save_filename(filter, fname);" to save anywhere.
// This function just creates a buffer with the save data in it.
// map = argument0
// flags = argument2 [optional]
var _map=-1;
var _flags=0;

_map=argument[0];
if( argument_count>1)_flags=argument[1];

var buff = buffer_create(1024*1024*4,buffer_grow,1);

with(_map)
{
    // Map version
    buffer_write(buff,buffer_u32, 4);
    buffer_write(buff,buffer_u32, 0);
    buffer_write(buff,buffer_u32, 0);
    buffer_write(buff,buffer_u32, 0);
    buffer_write(buff,buffer_u32, 0);
    buffer_write(buff,buffer_u32, 0);
    buffer_write(buff,buffer_u32, 0);
    buffer_write(buff,buffer_u32, 0);
    buffer_write(buff,buffer_u32, 0);
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
            var Spr = ds_grid_get(Sprites,xx,yy); //Spr is an array of all of the sprites in that cell
            var cnt = array_length_1d(Arr);       
            var sz = cnt;                      
            // Do we have any sprites in this column? If so... set the top bit of the column size.
            if( is_array(Spr) ) sz |= $8000;
 
            buffer_write(raw,buffer_u16,sz);       // size of column
            
            for(var zz=0;zz<cnt;zz++){
                var b = Arr[zz];
                buffer_write(raw,buffer_u16,b&$ffff);
                buffer_write(raw,buffer_u8,(b>>16)&$ff);
            }
            
            // IF we have sprites, write out the sprite block
            if( is_array(Spr) ) {
                sz = array_length_1d(Spr);

                // Write number of sprites in column (probably doesn't "need" 16bits)
                buffer_write(raw,buffer_u16,sz);
                for(i=0;i<sz;i++){
                    b = Spr[i];
                    if( is_array(b) ){
                        buffer_write(raw,buffer_u16,b[0]&$ffff);            // sprite type (doesn't need 16bits - some spare flags)
                        buffer_write(raw,buffer_u32,b[1]);                  // x(8),y(8),z(16) 
                        buffer_write(raw,buffer_u32,b[2]);                     // sx(4.4), sy(4.4), angle(8), flags(8)   (not yet)
                    }
                }
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
    for(var i=0;i<size;i++){
        var a = buffer_read(raw,buffer_u8);
        buffer_write(buff,buffer_u8,a);
    }

    // Write out number of block info structs we have
    size = block_info_size;
    buffer_write(buff, buffer_u32, size );
    
    // write out info's
    for(var i=0;i<size;i++;){
        var info = block_info[i];
        var len = array_length_1d(info);
        for(var l=0;l<BLK_FLAGS1;l++){
            buffer_write(buff, buffer_u16, info[l]);
        }
        
        // Do we need to save extended block info?
        var f = 0;
        if( info[BLK_FLAGS2]!=0 || info[BLK_OFFSETS1]!=0 || info[BLK_OFFSETS2]!=0 || info[BLK_OFFSETS3]!=0 ){ f=$80000000; }
        //info[BLK_FLAGS1]&=$7fffffff;
        buffer_write(buff, buffer_u32, info[BLK_FLAGS1]|f);
        if( f!=0 ){
            buffer_write(buff, buffer_u32, info[BLK_FLAGS2]);
            buffer_write(buff, buffer_u32, info[BLK_OFFSETS1]);
            buffer_write(buff, buffer_u32, info[BLK_OFFSETS2]);
            buffer_write(buff, buffer_u32, info[BLK_OFFSETS3]);
        }
    }
}


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

// Sort the real objects from the sissy ones
var numberOfObjects, n, p, inst;
numberOfObjects = instance_number(parObject);
n = 0;
p = 0;
repeat (numberOfObjects)
    {
    inst = instance_find(parObject, n++);
    if (ObjectGetObjectIndex(inst.object_index) != -1)
        object[p++] = inst;
    }
    
// Write number of objects to save
numberOfObjects = array_length_1d(object);
buffer_write(buff, buffer_u32, numberOfObjects);

// Go through all Objects and sqeeze the info together, then write to buffer
var type, xPos, yPos, zPos, rotation, final1, final2;
for (n=0; n<numberOfObjects; n++)
    {
    inst = object[n];
    with (inst)
        {
        // Get all the indivual values and fix their size
        type = ObjectGetObjectIndex(object_index) & $FF;
        xPos = floor(xstart) & $FFFF;
        yPos = floor(-ystart) & $FFFF;
        zPos = floor(zstart/64) & $FF;
        rotation = floor(phy_rotation/64) & $3F;
        
        // Compile all the stuff into two 32 bit values
        final1 = (type<<24) | (rotation<<10) | (zPos);
        final2 = (yPos<<16) | (xPos);
        
        // Write those values
        buffer_write(buff, buffer_u32, final1);
        buffer_write(buff, buffer_u32, final2);
        }
    }


//-----------------------------------------------------
// delete temp buffer
buffer_delete(raw);
return buff;

