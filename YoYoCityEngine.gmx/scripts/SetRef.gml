var v = ds_list_size(RefCount);
if( v<=(argument0-1)){
    ds_list_add(RefCount, argument1);
}else{
    ds_list_replace(RefCount, argument0, argument1);
}
