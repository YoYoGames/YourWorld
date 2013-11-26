/// UseWheel(SelectionInstance,Direction)
//
// Create/Remove a stack of blocks in the correct direction

_selection = argument0;
_dir = argument1;
{
    var x1,y1,z1,x2,y2,z2,face,dx,dy,dz;
    
    face = _selection.PickFace;
    x1 = _selection.PickX1;
    y1 = _selection.PickY1;
    z1 = _selection.PickZ1;
    x2 = _selection.PickX2;
    y2 = _selection.PickY2;
    z2 = _selection.PickZ2;
//    if( x2<x1){t=x1; x1=x2; x2=t; }
//    if( y2<y1){t=y1; y1=y2; y2=t; }
//    if( z2<z1){t=z1; z1=z2; z2=t; }
    
    switch(face){
        case 1: dx=0;dy=_dir;dz=0; break;        //top
        case 2: dx=0;dy=_dir;dz=0; break;        //bottom
        case 3: dx=_dir;dy=0;dz=0; break;        //left
        case 4: dx=_dir;dy=0;dz=0; break;        //right
        case 5: dx=0;dy=0;dz=_dir; break;        //lid
        case 6: dx=0;dy=0;dz=_dir; break;        //base
    }
    
        
    // if _dir>0 then ADD blocks, <0 to remove  blocks
   
    x2+=dx;
    y2+=dy;
    z2+=dz;
    
    _selection.PickX1 = x1;
    _selection.PickY1 = y1;
    _selection.PickZ1 = z1;
    _selection.PickX2 = x2;
    _selection.PickY2 = y2;
    _selection.PickZ2 = z2;

    x1=x2;
    y1=y2;
    z1=z2;
        
}

