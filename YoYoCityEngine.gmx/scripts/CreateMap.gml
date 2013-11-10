// Creates an empty map, with the world a simple ground (pavement) tile
// _width = argument0  (default = 256)
// _height= argument1  (default = 256)
// _depth = argument2  (default = 10)
// _gridcachesize = argument3 (default = 32)  
// _sidebase = argument4  (default = 0)
// _topbase = argument5  (default = 0)
// _pavement = argument6 (default = 0)  (adds on topbase later)
// _tilesize = argument7 (default = 64)
// _tileborder = argument8 (default = 70)

var _width,_height, _depth; 

_width = 256;
_height = 256;
_depth = 10;
_sidebase = 0;
_topbase = 0;
_tilesize = 64;
_tileborder = 70;
_pavement = 0;
_gridcachesize = 32;

var c = argument_count;
if( c>0 ) _width = argument[0];
if( c>1 ) _height = argument[1];
if( c>2 ) _depth = argument[2];
if( c>3 ) _gridcachesize = argument[3];
if( c>4 ) _sidebase = argument[4];
if( c>5 ) _topbase = argument[5];
if( c>6 ) _pavement = argument[6];
if( c>7 ) _tilesize = argument[7];
if( c>8 ) _tileborder = argument[8];




MapWidth = _width;
MapHeight = _height;
MapDepth = _depth;
SideBase = _sidebase;              // base of all SIDE tiles
TopBase = _topbase;                // base of all TOP tiles
TileSize = _tilesize;              // pixel size of all tiles
TileBorder = _tileborder;          // size or tile + surrounding border
PavementTile = _pavement;          // simple pavement tile
GridCacheSize = _gridcachesize;    // Size of a cache block
FreeList = ds_stack_create();      // create a new block_info free list

show_debug_message("w="+string(MapWidth)+", h="+string(MapHeight)+", d="+string(MapDepth)+", sb="+string(SideBase)+
                    ", tb="+string(TopBase)+", ts="+string(TileSize)+", tb="+string(TileBorder));

// First create the empty mesh cache
Cache = ds_grid_create(MapWidth,MapHeight);             // Mesh cache
Map = ds_grid_create(MapWidth,MapHeight);               // actual grid of arrays used for the map
RefCount = ds_list_create();
AddRef(1);                          // block "0" must ALWAYS have a ref
AddRef((MapHeight*MapWidth));       // empty map is filled woth pavement

for(var yy=0;yy<MapHeight;yy++){
    for(var xx=0;xx<MapWidth;xx++){
        var a=0;
        a[0]=1;                                         // point at bock
        ds_grid_set(Map,xx,yy,a);
        ds_grid_set(Cache,xx,yy,-1);                     // clear cache entry
    }
}
// Create the block info list
block_info=ds_list_create();

// block/cube 0 reserved for "empty"
var info = 0;
info[BLK_LEFT]   = -1;      // left
info[BLK_RIGHT]  = -1;      // right
info[BLK_TOP]    = -1;      // top
info[BLK_BOTTOM] = -1;      // bottom
info[BLK_LID]    = -1;      // lid
info[BLK_BASE]   = -1;      // behind (usually hidden)
info[BLK_FLAGS1] =  0;      // block flags #2 (32bits)
info[BLK_FLAGS2] =  0;      // block flags #1 (32bits)
ds_list_add( block_info, info );
    
info=0;            // reset array pointer
info[BLK_LEFT]   = -1;      // left
info[BLK_RIGHT]  = -1;      // right
info[BLK_TOP]    = -1;      // top
info[BLK_BOTTOM] = -1;      // bottom
info[BLK_LID]    = _pavement;      // lid
info[BLK_BASE]   = -1;      // behind (usually hidden)
info[BLK_FLAGS1] =  0;      // block flags #2 (32bits)
info[BLK_FLAGS2] =  0;      // block flags #1 (32bits)
ds_list_add( block_info, info );
    

