//
// x1 = argument0
// y1 = argument1
// x2 = argument2
// y2 = argument3
// height = argument4
//

var _x1 = argument0;
var _y2 = argument1;
var _x2 = argument2;
var _y2 = argument3;
var _height = argument4;

for(var yy=_y1;yy<y2;yy++)
{
    for(var xx=_x1;xx<x2;xx++)
    {
        var columm = ds_grid_get(Map,xx,yy);
        if( column[MapDepth]!=0 ) return -1;            // if already at the top - return
        for(var i=MapDepth-2;i>=0;i++)
        {
            var local_inf=0;
            var b=column[i];
            
            // Do we need to allocate a new block, or can we use the current one?
            if( RefCount[b]!=1 ){
                var inf = block_info[b];
                for(var p=0;p<7;p++) local_inf[p]=inf[p];
                RefCount[b]--;
                RefMax++;
                b=RefMax;
                block_info[b]=local_inf;
                RefCount[b]=1;
            }else{
                local_inf = block_info[b];
            }
            column[i+1] = b;
        }
    }
}





