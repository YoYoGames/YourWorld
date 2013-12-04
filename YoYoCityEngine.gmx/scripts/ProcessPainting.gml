/// ProcessPainting()
//
// Do "painting" on tiles (lids or sides)

// If any mouse click, select an area on screen
if( KMleft || KMright ) //|| KMmiddle )
{
    // Not currently picking
    if( PickingMode==-1)
    {
        // Still picking?
        if( global.DoPick!=0 ) exit;
        
        MButton=0;
        if( KMleft ) MButton = 1;
        if( KMright ) MButton = 2;
        if( KMmiddle ) MButton = 3;
        

        Pick(mouse_x,mouse_y);
        PickingMode=1;
        
        //debug("-----------------------------------------------------------------start ("+string(MButton)+", "+string(mouse_x)+","+string(mouse_y));
    }
    else if( PickingMode==1)
    {
        var map = global.Map;
        var pix = global.PickPixel;

        // Setup NEXT frame pick        
        Pick(mouse_x,mouse_y);  
        // Get picked pixel details. If false, we didn't click a tile. (location, face etc...)
        if( !ProcessPickPixel(pix) ) return false;;

        // Make sure this block is unique.
        blk = MakeUnique(map, TilePickX,TilePickY,TilePickZ);
        var info = map.block_info[blk];

        // Get the tile we've select (based on L/R mouse button)
        var tile = global.LeftMouseTile;
        if( KMright ) tile = global.RightMouseTile;
        
        // get flip+rotation flags into the right bits, and work out a mask
        var flags=global.FlipRotateFlags<<((TilePickFace-1)*3);
        var mask =$ffffffff-(7<<((TilePickFace-1)*3));
        
        // Now paint based on mode (lid or side)
        if( global.EditorMode_Sub==EDIT_SUB_LID )
        {
            switch(TilePickFace){
                case 5: info[BLK_LID]=tile; 
                        info[BLK_FLAGS1]=(info[BLK_FLAGS1]&mask)|flags;
                        break;          // paint "lids" only
                case 6: info[BLK_BASE]=tile; 
                        info[BLK_FLAGS1]=(info[BLK_FLAGS1]&mask)|flags;
                        break;
            }        
        }else if( global.EditorMode_Sub==EDIT_SUB_SIDE )
        {
            switch(TilePickFace){
                case 1: info[BLK_TOP]=tile; 
                        info[BLK_FLAGS1]=(info[BLK_FLAGS1]&mask)|flags;
                        break;
                case 2: info[BLK_BOTTOM]=tile;
                        info[BLK_FLAGS1]=(info[BLK_FLAGS1]&mask)|flags;
                        break;                
                case 3: info[BLK_LEFT]=tile; 
                        info[BLK_FLAGS1]=(info[BLK_FLAGS1]&mask)|flags;
                        break;                
                case 4: info[BLK_RIGHT]=tile; 
                        info[BLK_FLAGS1]=(info[BLK_FLAGS1]&mask)|flags;
                        break;                
            }
        }
        map.block_info[blk] = info;
        FreeCacheEntry(map, TilePickX, TilePickY );
    }
}else{
    PickingMode=-1;     // come out of picking mode.

}




