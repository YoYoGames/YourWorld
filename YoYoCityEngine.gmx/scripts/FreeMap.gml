/// Free the map completely


// First free the map arrays
for(var yy=0;yy<MapHeight;yy++){
    for(var xx=0;xx<MapWidth;xx++){
        ds_grid_set(Map,xx,yy,0);
    }
}
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
var len = array_length_1d(block_info);
for(xx=0;xx<len;xx++){
    block_info[xx]=0;
}
block_info=0;


// Lastly delete the ref count array, and the free array
ds_stack_destroy( FreeList );
RefCount = 0;


