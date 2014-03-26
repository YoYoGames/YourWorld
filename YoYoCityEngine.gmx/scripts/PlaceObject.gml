/// PlaceObject(map, button, x, y, z);
//

//show_debug_message("Setting sprites");

var _map    = argument0;
var _button = argument1;
var _x      = argument2;
var _y      = argument3;
var _z      = argument4;
var _sprite = -1;//argument5;

with (_map)
    {
    // Left click
    if (_button == 1)
        {
        var xx, yy, zz;
        xx = _x;   //The tile x
        yy = _y;   //The tile y
        zz = _z++; //The ACTUAL z (0-65535)
        
        var newObject;
        show_debug_message("global.LeftMouseSprite = "+string(global.LeftMouseSprite));
        newObject = instance_create(xx*64+32+irandom_range(-8, 8), -yy*64-32+irandom_range(-8, 8), ObjectGetIndex(global.LeftMouseSprite));
        newObject.z = zz*64+8;
        newObject.zstart = newObject.z;
        newObject.phy_rotation = random(360);
        
        /*
        show_debug_message("Clicked @ ("+string(xx)+","+string(yy)+","+string(zz)+")");

        if(( zz>=0 && zz<MapDepth ) && (xx>=0 && xx<MapWidth) && (yy>=0 && yy<MapHeight))
            {
            var gridx=xx;
            var gridy=yy;
            
            a = ds_grid_get(Sprites,gridx,gridy);
            
            // if its an array, then there are sprites here.
            var l = array_length_1d(a);
            
            if (!l)
                {
                var s;
                height = DecalGetHeight(_sprite);
                s[0]=_sprite;
                s[1]=0;
                s[1]+=(( (zz*oMap.TileSize)+height )<<16); // Z coordinate
                if (global.snapToGrid)
                    {
                    s[1] += (oMap.TileSize*0.5)<<8; // Y
                    s[1] += (oMap.TileSize*0.5);    // X
                    }
                else
                    {
                    s[1] += irandom_range(oMap.TileSize*0.25, oMap.TileSize*0.75)<<8; // Y
                    s[1] += irandom_range(oMap.TileSize*0.25, oMap.TileSize*0.75);    // X
                    }
                s[2]=0; //Extra info, currently null
                
                a[0]=s;
                
                //ds_grid_set(Sprites,gridx,gridy,a);
                //FreeCacheRegion(id,xx-1,yy-1, xx+1,yy+1);   
                //GenerateCacheRegion(id, xx-1    ,yy-1, xx+1,yy+1);
                }
            }
            */
        }
    
    // Right click, remove the sprite at location
    /*
    else if (_button == 2)
        {
        var xx, yy, zz;
        xx = _x;   //The tile x
        yy = _y;   //The tile y
        zz = _z++; //The ACTUAL z (0-65535)
        
        show_debug_message("Clicked @ ("+string(xx)+","+string(yy)+","+string(zz)+")");
        
        if (_z > 0)
            {
            ds_grid_set(Sprites, xx, yy, -1)
            FreeCacheRegion(id,_x-1,_y-1, _x+1,_y+1);   
            GenerateCacheRegion(id, _x-1,_y-1, _x+1,_y+1);  
            }
        }
    */
    }
    
