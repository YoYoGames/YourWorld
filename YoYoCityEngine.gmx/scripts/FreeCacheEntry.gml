/// Allocate a single cube in the world, and return the block_info index
/// x = argument0
/// y = argument1
var _x=argument0;
var _y=argument1;

var gx = floor( _x/GridCacheSize );
var gy = floor( _y/GridCacheSize );
if( gx<0 || gx>CacheWidth || gy<0 || gy>CacheHeight) return 0;
var MeshA = ds_grid_get(Cache,gx,gy);
if( is_array(MeshA) ){
    global.polys-=MeshA[1];
    if( MeshA[0]!=-1 ){
        vertex_delete_buffer(MeshA[0]);     // free VB
    }
    ds_grid_set(Cache,gx,gy,0);         // free grid slot
}


