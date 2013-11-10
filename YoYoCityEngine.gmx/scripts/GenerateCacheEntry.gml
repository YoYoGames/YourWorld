//
// Generate a mesh for a grid cell, and return and array holding the mesh and poly count
//
// mesh = GenerateGridRegion( GridX,GridY )
//
var gx = argument0;
var gy = argument1;

//show_debug_message("Cache: ("+string(gx)+","+string(gy)+")");
var Mesh = vertex_create_buffer_ext(128*1024);

// Get map bounds.
var x1 = gx*GridCacheSize;
var y1 = gy*GridCacheSize;
var x2 = x1+GridCacheSize;
var y2 = y1+GridCacheSize;

var polys = global.polys;

// keep local for faster access
var blockinfo = block_info;
var themap = Map;
vertex_begin(Mesh, CityFormat);
{
        global.cubes = 0;
        WSize = MapWidth*TileSize;
        HSize = MapHeight*TileSize;
        CubeEdge = TileSize;
        sp = CubeEdge;
      
        y=-y1*TileSize;
        for (var yy=y1; yy<y2; yy++)
        {
             x = x1*TileSize;
             for (var xx=x1; xx<x2; xx++)
             {
                // Look up column
                var u,d,l,r,lid,base,block,a,z,len; 
                
                var col = (yy*(MapDepth*MapWidth))+(xx*MapDepth);
                a = ds_grid_get(themap,xx,yy);                          

                z=0;    
                len = array_length_1d(a);   
                for(var zz=0; zz<len; zz++)
                {
                    block = a[zz];      // read block_info index out of column
                    if( block>0 )
                    {
                        // if not empty
                        var info = ds_list_find_value(blockinfo, block);
                        l = info[BLK_LEFT];
                        r = info[BLK_RIGHT];
                        t = info[BLK_TOP];
                        b = info[BLK_BOTTOM];
                        lid=info[BLK_LID];
                        base=info[BLK_BASE];
                        var flags = info[BLK_FLAGS1];
                        AddCube(Mesh, x,y-CubeEdge,z,  x+CubeEdge,y,z+CubeEdge, col+(zz|$80000000), t,b,l,r,lid,base, flags );
                    }
                    z-=sp;
                }
                x+=sp;
             }
             y-=sp;
      }
}       
x=0;
y=0;

vertex_end(Mesh);
vertex_freeze(Mesh);
var MeshA = 0;
MeshA[0]=Mesh;
MeshA[1]=global.polys-polys;
return MeshA;



