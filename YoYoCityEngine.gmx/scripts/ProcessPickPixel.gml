/// ProcessPick(screen_pixel);
//
//  Given the pixel read from the screen, workout what we've clicked.
//
//*****************************************************************************

var _colour;
_colour = argument0;

// Did we click on a tile?
if ((_colour&$80000000)!=0)
    {
    var map, c;
    map = global.Map;
    c = _colour&$3ffffff;
    PickType = PICK_TILE;
    TilePickY = c div (map.MapDepth*map.MapWidth);
    TilePickX = (c-(TilePickY*(map.MapDepth*map.MapWidth))) div (map.MapDepth);
    TilePickZ = floor(c mod map.MapDepth);
    TilePickFace = (_colour>>26)&7;
    //debug("Picked - "+string(TilePickX)+","+string(TilePickY)+","+string(TilePickZ) );
    return true;
    }
else
    {
    //debug("NONE:"+Hex(_colour)+","+string(_colour));
    return false;
    }

