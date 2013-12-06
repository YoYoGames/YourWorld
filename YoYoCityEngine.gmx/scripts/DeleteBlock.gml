/// DeleteBlock(map,x,y,z,remove,side,lid)
//
// Add a block to the map, and remove adjoining faces where required
//
// argument0 = xcoord
// argument1 = ycoord
// argument2 = zcoord
// argument3 = replace adjoining faces (true/false) [optional]
// argument4 = tile to put on side                  [optional]
// argument5 = tile to put on lid/base              [optional]
//
var _map=argument[0]
var _x=argument[1];
var _y=argument[2];
var _z=argument[3];
var _replace=true;
var _side=59;
var _lid=7;

if(argument_count>=5) _remove=argument[4];
if(argument_count>=6) _side=argument[5];
if(argument_count>=7) _lid=argument[6];


with(_map)
{
    if(_x<0 || _x>MapWidth || _y<0 || _y>MapHeight || _z<1 || _z>=MapDepth ) return -1;
    
    FreeBlock(id, _x,_y,_z);
     
    if( _replace )
    {
        // Check block to the left
        var blk = GetBlockIndex(_x-1,_y,_z)
        if( blk>0 ){
            blk = MakeUnique(id, _x-1,_y,_z);
            var inf= block_info[blk];           // get the info we're about change
            inf[BLK_RIGHT]=_side;                 // clear the block
            block_info[blk]=inf;
        }
    
        // Check block to the right
        var blk = GetBlockIndex(_x+1,_y,_z)
        if( blk>0 ){
            blk = MakeUnique(id, _x+1,_y,_z);
            var inf= block_info[blk];           // get the info we're about change
            inf[BLK_LEFT]=_side;                 // clear the block
            block_info[blk]=inf;
        }
    
        // Check block to the bottom
        var blk = GetBlockIndex(_x,_y-1,_z)
        if( blk>0 ){
            blk = MakeUnique(id, _x,_y-1,_z);
            var inf= block_info[blk];           // get the info we're about change
            inf[BLK_BOTTOM]=_side;                 // clear the block
            block_info[blk]=inf;
        }
        
        // Check block to the top
        var blk = GetBlockIndex(_x,_y+1,_z)
        if( blk>0 ){
            blk = MakeUnique(id, _x,_y+1,_z);
            var inf= block_info[blk];           // get the info we're about change
            inf[BLK_TOP]=_side;                 // clear the block
            block_info[blk]=inf;
        }
    
        
        // Check block to the base
        var blk = GetBlockIndex(_x,_y,_z-1)
        if( blk>0 ){
            blk = MakeUnique(id, _x,_y,_z-1);
            var inf= block_info[blk];           // get the info we're about change
            inf[BLK_LID]=_lid;                 // clear the block
            block_info[blk]=inf;
        }
    
       
        // Check block to the lid
        var blk = GetBlockIndex(_x,_y,_z+1)
        if( blk>0 ){
            blk = MakeUnique(id, _x,_y,_z+1);
            var inf= block_info[blk];           // get the info we're about change
            inf[BLK_BASE]=_lid;                 // clear the block
            block_info[blk]=inf;
        }   
    }
}


