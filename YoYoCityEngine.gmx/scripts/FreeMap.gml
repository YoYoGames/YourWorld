/// Free the map completely


// First free the map arrays
ds_grid_destroy(Map);
Map=-1;

// Next destroy the cache
var gw=(MapWidth+GridCacheSize-1)/GridCacheSize;
var gh=(MapHeight+GridCacheSize-1)/GridCacheSize;
for(var yy=0;yy<gh;yy++){
    for(var xx=0;xx<gw;xx++){
        FreeCacheEntry(xx,yy);
    }
}
ds_grid_destroy(Cache);
Cache=-1;

// Now delete the block_info structs
ds_list_destroy(block_info);
block_info=-1;


// Lastly delete the ref count array, and the free array
ds_stack_destroy( FreeList );
ds_list_destroy(RefCount);


