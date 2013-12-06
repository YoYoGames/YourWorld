/// ProcessPainting()
//
// Do "painting" on tiles (lids or sides)

// If control pressed, then allow 2D selection of a set of faces.
if( (KMleft || KMright) && (KZctrl || SelectionPick) )
{
    // Not currently picking
    if( PickingMode==-1)
    {
        KillSelection();

        MButton=0;
        if( KMleft ) MButton = 1;
        if( KMright ) MButton = 2;
        if( KMmiddle ) MButton = 3;
        
        // Still picking?
        if( global.DoPick!=0 ) exit;
        Pick(mouse_x,mouse_y);
        PickingMode=1;
        SelectionPick=true;        
    }
    else if( PickingMode==1){
        // First result
        var pix = global.PickPixel;
        
        ProcessPickPixel(pix);
        PickingMode=2;

        // Place anchor
        PickAnchor=true;
        PickX1=TilePickX;
        PickY1=TilePickY;
        PickZ1=TilePickZ;
        PickX2=TilePickX;
        PickY2=TilePickY;
        PickZ1=TilePickZ;
        PickFace=TilePickFace;
        Pick(mouse_x,mouse_y);     
        
        SelectionInstance = instance_create(0,0,o3DSelection);
        SelectionInstance.Controller = id;
        SelectionInstance.PickX1 = PickX1;
        SelectionInstance.PickY1 = PickY1;
        SelectionInstance.PickZ1 = PickZ1;
        SelectionInstance.PickX2 = PickX2;
        SelectionInstance.PickY2 = PickY2;
        SelectionInstance.PickZ2 = PickZ2;
        SelectionInstance.PickFace = TilePickFace;
        SelectionInstance.Mode = 2;         // face mode

        // If we haven't selected the correct face for this mode, then mark red for an error.
        if( global.EditorMode_Sub==EDIT_SUB_LID ){
            if( PickFace!=5 && PickFace!=6 ) SelectionInstance.colour = $a0ff0000;
        }else{
            if( PickFace<1 || PickFace>4 ) SelectionInstance.colour = $a0ff0000;
        }
    }
    else if( PickingMode==2){
        // Selecting dragging.....
        var pix = global.PickPixel;
        ProcessPickPixel(pix);
        // Place anchor
        PickX2=TilePickX;
        PickY2=TilePickY;
        PickZ2=TilePickZ;
        Pick(mouse_x,mouse_y);
        
        SelectionInstance.PickX2 = PickX2;
        SelectionInstance.PickY2 = PickY2;
        SelectionInstance.PickZ2 = PickZ2;        
        switch(SelectionInstance.PickFace){
            case 1: //top
            case 2: //bottom
                    SelectionInstance.PickY2 = SelectionInstance.PickY1;
                    break;
            case 3: //left
            case 4: //right
                    SelectionInstance.PickX2 = SelectionInstance.PickX1;
                    break;
            case 5: //left
            case 6: //right
                    SelectionInstance.PickZ2 = SelectionInstance.PickZ1;
                    break;
        }
    }

}else if( !KMleft && !KMright && !KMmiddle && PickingMode>1)
{      
    SelectionPick=false;
    PickingMode=-1; 
}
else if( (KMleft || KMright) && (!KZctrl && !SelectionPick) )
{
    // if there is a selection, then clicking will cancel it.
    if( instance_exists(SelectionInstance) ){
        KillSelection();
        PickingMode=2;
        return -1;
    }  

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

if( (PickingMode==-1) && (SelectionInstance>0) && (instance_exists(SelectionInstance)) )
{
    if( Kinsert ) FillSelection(SelectionInstance, SelectionInstance.PickFace);
    if( Kdelete) DeleteSelection(SelectionInstance);
    if( Kescape) KillSelection();
}
