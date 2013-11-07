//
// Add a block to the map, and remove adjoining faces where required
//
// AddBlock( x,y,z, remove )
// x = xcoord
// y = ycoord
// z = zcoord
// remove = remove adjoining faces (true/false) [optional]
// side = tile to put on side [optional]
// lid = tile to put on lid/base [optional]
//
var _x=argument[0];
var _y=argument[1];
var _z=argument[2];
var _remove=true;
var _side=1;
var _lid=1;

if(argument_count>=4) _remove=argument[3];
if(argument_count>=5) _side=argument[4];
if(argument_count>=6) _lid=argument[5];


var block = AllocBlock(_x,_y,_z);
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
 




