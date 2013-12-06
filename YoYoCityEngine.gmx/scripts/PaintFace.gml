/// PaintFace(map, dx,dy,dz,tile)
// Paint face IF there is a block there, AND there is already a face there!
var map = argument0;
var dx = argument1;
var dy = argument2;
var dz = argument3;
var tile = argument4;
{
    // face mode
    var ref = GetRefCount(map, dx,dy,dz);
    
    // block there at all?
    if( ref>0 ) 
    {                    
        blk = MakeUnique(map, dx,dy,dz);
        var info = map.block_info[blk];

        // Get the tile we've select (based on L/R mouse button)
        var tile = global.LeftMouseTile;
        if( KMright ) tile = global.RightMouseTile;
        
        
        var face = SelectionInstance.PickFace;
        // get flip+rotation flags into the right bits, and work out a mask
        var flags=global.FlipRotateFlags<<((face-1)*3);
        var mask =$ffffffff-(7<<((face-1)*3));
        
        // Now paint based on mode (lid or side)
        if( global.EditorMode_Sub==EDIT_SUB_LID )
        {
            switch(face){
                case 5: if( info[BLK_LID]>=0 ) {
                            info[BLK_LID]=tile; 
                            info[BLK_FLAGS1]=(info[BLK_FLAGS1]&mask)|flags;
                        }
                        break;          // paint "lids" only
                case 6: if( info[BLK_BASE]>=0) {
                            info[BLK_BASE]=tile; 
                            info[BLK_FLAGS1]=(info[BLK_FLAGS1]&mask)|flags;
                        }
                        break;
            }        
        }else if( global.EditorMode_Sub==EDIT_SUB_SIDE )
        {
            switch(face){
                case 1: if( info[BLK_TOP]>=0 ){
                            info[BLK_TOP]=tile; 
                            info[BLK_FLAGS1]=(info[BLK_FLAGS1]&mask)|flags;
                        }
                        break;
                case 2: if( info[BLK_BOTTOM]>=0 ){
                            info[BLK_BOTTOM]=tile;
                            info[BLK_FLAGS1]=(info[BLK_FLAGS1]&mask)|flags;
                        }
                        break;                
                case 3: if( info[BLK_LEFT]>=0 ){
                            info[BLK_LEFT]=tile; 
                            info[BLK_FLAGS1]=(info[BLK_FLAGS1]&mask)|flags;
                        }
                        break;                
                case 4: if( info[BLK_RIGHT]>=0 ){
                            info[BLK_RIGHT]=tile; 
                            info[BLK_FLAGS1]=(info[BLK_FLAGS1]&mask)|flags;
                        }
                        break;                
            }
        }
        map.block_info[blk] = info;
    }
}
