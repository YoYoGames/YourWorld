/// Free the mesh for a cache entry
/// x = argument0
/// y = argument1
var _x=argument0;
var _y=argument1;

var gx = floor( _x/GridCacheSize );
var gy = floor( _y/GridCacheSize );
var MeshA = ds_grid_get(Cache,gx,gy);
if( is_array(MeshA) ){
    global.polys-=MeshA[1];
    vertex_delete_buffer(MeshA[0]);     // free VB
    ds_grid_set(Cache,gx,gy,0);         // free grid slot
}


