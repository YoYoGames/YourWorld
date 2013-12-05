/// ProcessPick()
//
// Select 3D areas and fill/delete them. Also allow single cube add/remove.

// If any mouse click, select an area on screen
if( (KMleft || KMright || KMmiddle) && KZctrl )
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
        
        //debug("-----------------------------------------------------------------start ("+string(MButton)+", "+string(mouse_x)+","+string(mouse_y));
    }
    else if( PickingMode==1){
        // First result
        var pix = global.PickPixel;
        //debug("mouse=("+string(global.Map.MouseX)+","+string(global.Map.MouseY)+")    pixel="+Hex(pix)+"  Button="+string(MButton) );
        
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
        SelectionInstance.Mode = 1;         // cube mode
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
    }
}else{    
    if( !KMleft && !KMright && !KMmiddle && PickingMode>1)
    {
        /*if( PickX1==PickX2 && PickY1==PickY2 && PickZ1==PickZ1 )
        {
            // If we picked a block... deal with a single block
            SetSingleBlock( global.Map, MButton, PickX1,PickY1,PickZ1, PickFace );
            with(SelectionInstance) { instance_destroy(); }
        }*/
        PickingMode=-1; 
        //debug("-----------------------------------------------------------------end");
    }else 
        // Not selection mode (CTRL not held down)
        if (KMleft || KMright || KMmiddle){
        
            // Not currently picking
            if( PickingMode==-1)
            {
                MButton=0;
                if( KMleft ) MButton = 1;
                if( KMright ) MButton = 2;
                if( KMmiddle ) MButton = 3;
                    
                KillSelection();
        
                MButton=0;
                if( KMleft ) MButton = 1;
                if( KMright ) MButton = 2;
                if( KMmiddle ) MButton = 3;
                
                // Still picking?
                if( global.DoPick!=0 ) exit;
                Pick(mouse_x,mouse_y);
                PickingMode=1;            
            }else if( PickingMode==1){
                    // First result
                    var pix = global.PickPixel;
                    //debug("mouse=("+string(global.Map.MouseX)+","+string(global.Map.MouseY)+")    pixel="+Hex(pix)+"  Button="+string(MButton) );
                    
                    ProcessPickPixel(pix);
                    PickingMode=2;
                    // set single block            
                    SetSingleBlock( global.Map, MButton, TilePickX,TilePickY,TilePickZ, TilePickFace );
                }
            }else{
                // Finished adding a single block... so just wait until mouse is lifted
            }
}

// use the wheel to go up and down (face specific)
if( (PickingMode==-1) && (SelectionInstance>0) && (instance_exists(SelectionInstance)) ){
    if( KMwheelup ) UseWheel(SelectionInstance,1);
    if( KMwheeldown ) UseWheel(SelectionInstance,-1);
    if( Kinsert ) FillSelection(SelectionInstance);
    if( Kdelete) DeleteSelection(SelectionInstance);
    if( Kescape) KillSelection();
}



