/// AddBlock(map,x,y,z,remove_faces,side,lid )
//
// Add a block to the map, and remove adjoining faces where required
//
// x = xcoord
// y = ycoord
// z = zcoord
// remove = remove adjoining faces (true/false) [optional]
// side = tile to put on side [optional]
// lid = tile to put on lid/base [optional]
//
var _map=argument[0];
var _x=argument[1];
var _y=argument[2];
var _z=argument[3];
var _remove=true;
var _side=59;
var _lid=31;

if(argument_count>=5) _remove=argument[4];
if(argument_count>=6) _side=argument[5];
if(argument_count>=7) _lid=argument[6];



with(_map)
{    
    if(_x<0 || _x>MapWidth || _y<0 || _y>MapHeight || _z<0 || _z>MapDepth ) return -1;

    var block = AllocBlock(id,_x,_y,_z);
    var info = block_info[block];
    info[BLK_LEFT]   = _side;       // left
    info[BLK_RIGHT]  = _side;       // right
    info[BLK_TOP]    = _side;       // top
    info[BLK_BOTTOM] = _side;       // bottom
    info[BLK_LID]    = _lid;        // lid
    info[BLK_BASE]   = _lid;        // behind (usually hidden)
    info[BLK_FLAGS1] =  0;          // block flags #2 (32bits)
    info[BLK_FLAGS2] =  0;          // block flags #1 (32bits)
    block_info[block]=info;
     
    if( _remove )
    {
        // Check block to the left
        var blk = GetBlockIndex(_x-1,_y,_z)
        if( blk>0 ){
            blk = MakeUnique(id, _x-1,_y,_z);
            var inf= block_info[blk];           // get the info we're about change
            inf[BLK_RIGHT]=-1;                 // clear the block
            info[BLK_LEFT]=-1;                 // clear the block        
            block_info[blk]=inf;
        }
    
        // Check block to the right
        var blk = GetBlockIndex(_x+1,_y,_z)
        if( blk>0 ){
            blk = MakeUnique(id, _x+1,_y,_z);
            var inf= block_info[blk];           // get the info we're about change
            inf[BLK_LEFT]=-1;                 // clear the block
            info[BLK_RIGHT]=-1;                 // clear the block        
            block_info[blk]=inf;
        }
    
        // Check block to the bottom
        var blk = GetBlockIndex(_x,_y-1,_z)
        if( blk>0 ){
            blk = MakeUnique(id, _x,_y-1,_z);
            var inf= block_info[blk];           // get the info we're about change
            inf[BLK_BOTTOM]=-1;                 // clear the block
            info[BLK_TOP]=-1;                 // clear the block        
            block_info[blk]=inf;
        }
        
        // Check block to the top
        var blk = GetBlockIndex(_x,_y+1,_z)
        if( blk>0 ){
            blk = MakeUnique(id, _x,_y+1,_z);
            var inf= block_info[blk];           // get the info we're about change
            inf[BLK_TOP]=-1;                 // clear the block
            info[BLK_BOTTOM]=-1;                 // clear the block        
            block_info[blk]=inf;
        }
    
        
        // Check block to the base
        var blk = GetBlockIndex(_x,_y,_z-1)
        if( blk>0 ){
            blk = MakeUnique(id, _x,_y,_z-1);
            var inf= block_info[blk];           // get the info we're about change
            inf[BLK_LID]=-1;                 // clear the block
            info[BLK_BASE]=-1;                 // clear the block        
            block_info[blk]=inf;
        }
    
       
        // Check block to the lid
        var blk = GetBlockIndex(_x,_y,_z+1)
        if( blk>0 ){
            blk = MakeUnique(id, _x,_y,_z+1);
            var inf= block_info[blk];           // get the info we're about change
            inf[BLK_BASE]=-1;                 // clear the block
            info[BLK_LID]=-1;                 // clear the block        
            block_info[blk]=inf;
        }
             
        
    }
}


