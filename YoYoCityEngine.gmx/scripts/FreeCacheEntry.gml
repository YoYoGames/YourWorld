/// FreeCacheEntry(map,GridCellX,GridCellY)
//
var _map=argument0;
var _x=argument1;
var _y=argument2;

with(_map)
{
    var gx = floor( _x/GridCacheSize );
    var gy = floor( _y/GridCacheSize );
    if( gx<0 || gx>CacheWidth || gy<0 || gy>CacheHeight) return 0;
    var MeshA = ds_grid_get(Cache,gx,gy);
    if( is_array(MeshA) ){
        global.polys-=MeshA[2];
        if( MeshA[0]!=-1 ){
            vertex_delete_buffer(MeshA[0]);     // free VB
        }
        if( MeshA[1]!=-1 ){
            vertex_delete_buffer(MeshA[1]);     // free VB
        }
        if( MeshA[3]!=-1 ){
            vertex_delete_buffer(MeshA[3]);     // free VB
        }
        ds_grid_set(Cache,gx,gy,0);         // free grid slot
    }
}

