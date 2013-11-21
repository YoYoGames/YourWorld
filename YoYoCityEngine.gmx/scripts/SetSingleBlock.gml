/// SetSingleBlock(map, button,x,y,z,face)
//

var _map=argument0;
var _button=argument1;
var _x=argument2;
var _y=argument3;
var _z=argument4;
var _face=argument5;

with(_map)
{
    // Left click
    if( _button==1 )
    {
        debug("(1): ("+string(_x)+","+string(_y)+","+string(_z)+") - "+GetFace(_face));
        var xx,yy,zz;
        xx=_x;
        yy=_y;
        zz=_z 
        switch(_face){
            case 1:yy--; break;
            case 2:yy++; break;
            case 3:xx--; break;
            case 4:xx++; break;
            case 5:zz++; break;
            case 6:zz--; break;
        }

        if(( zz>=0 && zz<MapDepth ) && (xx>=0 && xx<MapWidth) && (yy>=0 && yy<MapHeight))
        {        
            var blk = AddBlock(xx,yy,zz);
            FreeCacheRegion(xx-1,yy-1, xx+1,yy+1);   
        }
    }    
    // Right click
    else if( _button==2 )
    {
        if( _z>0 )
        {       
            DeleteBlock(_x,_y,_z);
            FreeCacheRegion(_x-1,_y-1, _x+1,_y+1);   
        }
    }
    
    // middle "paint"
    else if( _button==3 )
    {
        var SideBlock = 2;
        var LidBlock = 15;
        var xx,yy,zz;
        xx=_x;
        yy=_y;
        zz=_z 
        if(( zz>=0 && zz<MapDepth ) && (xx>=0 && xx<MapWidth) && (yy>=0 && yy<MapHeight))
        {
            var blk = MakeUnique(xx,yy,zz);
            var info = block_info[blk];
            switch(_face){
                case 1: info[BLK_TOP]=SideBlock; break;
                case 2: info[BLK_BOTTOM]=SideBlock; break;
                case 3: info[BLK_LEFT]=SideBlock; break;
                case 4: info[BLK_RIGHT]=SideBlock; break;
                case 5: info[BLK_LID]=LidBlock; break;
                case 6: info[BLK_BASE]=LidBlock; break;
            }
            block_info[blk] = info;
            FreeCacheRegion(xx-1,yy-1, xx+1,yy+1);   
       }
    }
           
}

