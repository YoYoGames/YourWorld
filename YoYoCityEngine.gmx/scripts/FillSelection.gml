/// FillSelection(SelectionInstance,Face)
//
// Create/Remove a stack of blocks in the correct direction. If face is -1 then fill with blocks

var _selection = 0;
var _face = -1;

if( argument_count>0 ) _selection = argument[0];
if( argument_count>1 ) _face = argument[1];
{
    var x1,y1,z1,x2,y2,z2,dx,dy,dz;
    
    x1 = _selection.PickX1;
    y1 = _selection.PickY1;
    z1 = _selection.PickZ1;
    x2 = _selection.PickX2;
    y2 = _selection.PickY2;
    z2 = _selection.PickZ2;
    if( x2<x1){t=x1; x1=x2; x2=t; }
    if( y2<y1){t=y1; y1=y2; y2=t; }
    if( z2<z1){t=z1; z1=z2; z2=t; }

    for(var dy=y1;dy<=y2;dy++){    
        for(var dx=x1;dx<=x2;dx++){
            for(var dz=z1;dz<=z2;dz++){
                if( _face==-1 ) {
                    AddBlock(global.Map, dx,dy,dz,true,1,2);
                }else{
                    PaintFace(global.Map, dx,dy,dz, global.LeftMouseTile);
                }
            }    
        }    
    }
            
    FreeCacheRegion(global.Map, x1-1,y1-1,x2+1,y2+1);
    GenerateCacheRegion(global.Map, x1-1,y1-1, x2+1,y2+1);      
}



