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
        
        // Now paint based on mode (lid or side)
        if( global.EditorMode_Sub==EDIT_SUB_LID )
        {
            switch(TilePickFace){
                case 5: info[BLK_LID]=tile; break;          // paint "lids" only
                case 6: info[BLK_BASE]=tile; break;
            }        
        }else if( global.EditorMode_Sub==EDIT_SUB_SIDE )
        {
            switch(TilePickFace){
                case 1: info[BLK_TOP]=tile; break;
                case 2: info[BLK_BOTTOM]=tile; break;
                case 3: info[BLK_LEFT]=tile; break;
                case 4: info[BLK_RIGHT]=tile; break;
            }
        }
        map.block_info[blk] = info;
        FreeCacheEntry(map, TilePickX, TilePickY );
    }
}else{
    PickingMode=-1;     // come out of picking mode.

}




