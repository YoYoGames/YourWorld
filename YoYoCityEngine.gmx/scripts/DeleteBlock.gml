//
// Add a block to the map, and remove adjoining faces where required
//
// AddBlock( x,y,z, remove )
// argument0 = xcoord
// argument1 = ycoord
// argument2 = zcoord
// argument3 = replace adjoining faces (true/false) [optional]
// argument4 = tile to put on side                  [optional]
// argument5 = tile to put on lid/base              [optional]
//
var _x=argument[0];
var _y=argument[1];
var _z=argument[2];
var _replace=true;
var _side=1;
var _lid=1;

if(argument_count>=4) _remove=argument[3];
if(argument_count>=5) _side=argument[4];
if(argument_count>=6) _lid=argument[5];

FreeBlock(_x,_y,_z);
 
if( _replace )
{
    // Check block to the left
    var blk = GetBlockIndex(_x-1,_y,_z)
    if( blk>0 ){
        blk = MakeUnique(_x-1,_y,_z);
        var inf= ds_list_find_value(block_info,blk);           // get the info we're about change
        inf[BLK_RIGHT]=_side;                 // clear the block
        ds_list_replace(block_info,blk,inf);
    }

    // Check block to the right
    var blk = GetBlockIndex(_x+1,_y,_z)
    if( blk>0 ){
        blk = MakeUnique(_x+1,_y,_z);
        var inf= ds_list_find_value(block_info,blk);           // get the info we're about change
        inf[BLK_LEFT]=_side;                 // clear the block
        ds_list_replace(block_info,blk,inf);
    }

    // Check block to the bottom
    var blk = GetBlockIndex(_x,_y-1,_z)
    if( blk>0 ){
        blk = MakeUnique(_x,_y-1,_z);
        var inf= ds_list_find_value(block_info,blk);           // get the info we're about change
        inf[BLK_BOTTOM]=_side;                 // clear the block
        ds_list_replace(block_info,blk,inf);
    }
    
    // Check block to the top
    var blk = GetBlockIndex(_x,_y+1,_z)
    if( blk>0 ){
        blk = MakeUnique(_x,_y+1,_z);
        var inf= ds_list_find_value(block_info,blk);           // get the info we're about change
        inf[BLK_TOP]=_side;                 // clear the block
        ds_list_replace(block_info,blk,inf);
    }

    
    // Check block to the base
    var blk = GetBlockIndex(_x,_y,_z-1)
    if( blk>0 ){
        blk = MakeUnique(_x,_y,_z-1);
        var inf= ds_list_find_value(block_info,blk);           // get the info we're about change
        inf[BLK_LID]=_lid;                 // clear the block
        ds_list_replace(block_info,blk,inf);
    }

   
    // Check block to the lid
    var blk = GetBlockIndex(_x,_y,_z+1)
    if( blk>0 ){
        blk = MakeUnique(_x,_y,_z+1);
        var inf= ds_list_find_value(block_info,blk);           // get the info we're about change
        inf[BLK_BASE]=_lid;                 // clear the block
        ds_list_replace(block_info,blk,inf);
    }
         
    
}



