/// AddCube(x1,y1,z1,x2,y2,z2,colour,top,bottom,left,right,lid,base,flip_flags)
//
// Add a cube to a mesh
//
// argument0 = model
// argument1,argument2,argument3 = topleft x,y,z
// argument4,argument5,argument6 = bottom right x,y,z
// argument7 = colour
// argument8 - tile top
// argument9 - tile bottom
// argument10 - tile left
// argument11 - tile right
// argument12 - tile lid
// argument13 - tile base
// argument14 - flip flags
//              %00000000000LST555444333222111000  (face 000= RHV =Rotate90, Flip-Horizontal, Flip-Vertical)
//              face 0=top,1=bottom,2=left,3=right,4=lid,5=base
//              T = flatten TOP+BOTTOM
//              S = Flatten SIDES (left/right)
//              L = flatten LID+BASE
                
// Get vertex buffer we're building into
var buff = argument0

var x1 = argument1;
var y1 = argument2;
var z1 = argument3;

var x2 = argument4;
var y2 = argument5;
var z2 = argument6;

var col = argument7;

var tile0 = argument8;
var tile1 = argument9;
var tile2 = argument10;
var tile3 = argument11;
var tile4 = argument12;
var tile5 = argument13;

var flags = argument14;

var x2,x3,x4,x5,x6,x7,x8;
var y2,y3,y4,y5,y6,y7,y8;
var z2,z3,z4,z5,z6,z7,z8;



// get textel sizes based on the tile+border size
var PerRow = floor(sprite_get_width(StyleSprite)/TileBorder);     // Number of tiles per row
var border = (TileBorder - TileSize)/2;
var OneOverW  = 1.0/sprite_get_width(StyleSprite);
var OneOverH = 1.0/sprite_get_height(StyleSprite);
var Width64  = OneOverW*(TileSize);
var Height64 = OneOverH*(TileSize);

var u,v,flag;

// Keep these in the instance, so they aren't copied inside functions
//uvs=0; (dont keep remaking array, just overwrite)

// top
if( tile0>=0 ){
    u = ((floor(tile0 % PerRow) * TileBorder)+border) * OneOverW;
    v = ((floor(tile0 / PerRow) * TileBorder)+border) * OneOverH;
    
    var c=col|(1<<26);  // get the block ID+the face
    
    uvs[0]=u;
    uvs[1]=v;
    uvs[2]=u+Width64;
    uvs[3]=v;
    uvs[4]=u+Width64;
    uvs[5]=v+Height64;
    uvs[6]=u;
    uvs[7]=v+Height64;
    flag = flags&7;
    if(flag!=0){
        FlipRotateTile(flag);
    }    
    
    vertex_position_3d(buff, x1,y2,z1);         // topleft
    vertex_normal(buff, 0,1,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[2],uvs[3]);

    vertex_position_3d(buff, x1,y2,z2);
    vertex_normal(buff, 0,1,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[4],uvs[5]);

    vertex_position_3d(buff, x2,y2,z2);
    vertex_normal(buff, 0,1,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[6],uvs[7]);
    

    vertex_position_3d(buff, x2,y2,z2);
    vertex_normal(buff, 0,1,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[6],uvs[7]);

    vertex_position_3d(buff, x2,y2,z1);
    vertex_normal(buff, 0,1,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[0],uvs[1]);

    vertex_position_3d(buff, x1,y2,z1);
    vertex_normal(buff, 0,1,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[2],uvs[3]);

    global.polys+=2;
}



// bottom
if( tile1>=0 ){
    u = ((floor(tile1 % PerRow) * TileBorder)+border) * OneOverW;
    v = ((floor(tile1 / PerRow) * TileBorder)+border) * OneOverH;
    
    var c=col|(2<<26);      // get the block ID+the face
    
    uvs[0]=u;
    uvs[1]=v;
    uvs[2]=u+Width64;
    uvs[3]=v;
    uvs[4]=u+Width64;
    uvs[5]=v+Height64;
    uvs[6]=u;
    uvs[7]=v+Height64;
    
    flag = (flags>>3)&7;
    if(flag!=0){
        FlipRotateTile(flag);
    }    


    vertex_position_3d(buff, x1,y1,z1);
    vertex_normal(buff, 0,-1,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[0],uvs[1]);

    vertex_position_3d(buff, x2,y1,z1);
    vertex_normal(buff, 0,-1,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[2],uvs[3]);

    vertex_position_3d(buff, x2,y1,z2);
    vertex_normal(buff, 0,-1,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[4],uvs[5]);
    
    
    

    vertex_position_3d(buff, x2,y1,z2);
    vertex_normal(buff, 0,-1,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[4],uvs[5]);

    vertex_position_3d(buff, x1,y1,z2);
    vertex_normal(buff, 0,-1,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[6],uvs[7]);

    vertex_position_3d(buff, x1,y1,z1);
    vertex_normal(buff, 0,-1,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[0],uvs[1]);

    global.polys+=2;
}



// left
if( tile2>=0 ){
    u = ((floor(tile2 % PerRow) * TileBorder)+border) * OneOverW;
    v = ((floor(tile2 / PerRow) * TileBorder)+border) * OneOverH;
    
    var c=col|(3<<26);
    
    uvs[0]=u;
    uvs[1]=v;
    uvs[2]=u+Width64;
    uvs[3]=v;
    uvs[4]=u+Width64;
    uvs[5]=v+Height64;
    uvs[6]=u;
    uvs[7]=v+Height64;
    flag = (flags>>6)&7;
    if(flag!=0){
        FlipRotateTile(flag);
    }    
        
    vertex_position_3d(buff, x1,y1,z1);
    vertex_normal(buff, -1,0,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[2],uvs[3]);

    vertex_position_3d(buff, x1,y1,z2);
    vertex_normal(buff, -1,0,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[4],uvs[5]);

    vertex_position_3d(buff, x1,y2,z2);
    vertex_normal(buff, -1,0,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[6],uvs[7]);
    

    vertex_position_3d(buff, x1,y2,z2);
    vertex_normal(buff, -1,0,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[6],uvs[7]);

    vertex_position_3d(buff, x1,y2,z1);
    vertex_normal(buff, -1,0,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[0],uvs[1]);

    vertex_position_3d(buff, x1,y1,z1);
    vertex_normal(buff, -1,0,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[2],uvs[3]);
    
    global.polys+=2;
}


// right
if( tile3>=0 ){
    u = ((floor(tile3 % PerRow) * TileBorder)+border) * OneOverW;
    v = ((floor(tile3 / PerRow) * TileBorder)+border) * OneOverH;
    
    var c=col|(4<<26);
        
    uvs[0]=u;
    uvs[1]=v;
    uvs[2]=u+Width64;
    uvs[3]=v;
    uvs[4]=u+Width64;
    uvs[5]=v+Height64;
    uvs[6]=u;
    uvs[7]=v+Height64;
    flag = (flags>>9)&7;
    if(flag!=0){
        FlipRotateTile(flag);
    } 
    
    vertex_position_3d(buff, x2,y1,z1);
    vertex_normal(buff, 1,0,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[0],uvs[1]);

    vertex_position_3d(buff, x2,y2,z1);
    vertex_normal(buff, 1,0,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[2],uvs[3]);

    vertex_position_3d(buff, x2,y2,z2);
    vertex_normal(buff, 1,0,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[4],uvs[5]);
    

    
    
    vertex_position_3d(buff, x2,y2,z2);
    vertex_normal(buff, 1,0,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[4],uvs[5]);

    vertex_position_3d(buff, x2,y1,z2);
    vertex_normal(buff, 1,0,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[6],uvs[7]);

    vertex_position_3d(buff, x2,y1,z1);
    vertex_normal(buff, 1,0,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[0],uvs[1]);
    
    global.polys+=2;
}



// lid
if( tile4>=0 ){
    tile4+=TopBase;
    u = ((floor(tile4 % PerRow) * TileBorder)+border)*OneOverW;
    v = ((floor(tile4 / PerRow) * TileBorder)+border)*OneOverH;
    
    var c=col|(5<<26);
    
    uvs[0]=u;
    uvs[1]=v;
    uvs[2]=u+Width64;
    uvs[3]=v;
    uvs[4]=u+Width64;
    uvs[5]=v+Height64;
    uvs[6]=u;
    uvs[7]=v+Height64;
    flag = (flags>>12)&7;
    if(flag!=0){
        FlipRotateTile(flag);
    } 

    
    vertex_position_3d(buff, x1,y1,z1);
    vertex_normal(buff, 0,0,-1);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[6],uvs[7]);

    vertex_position_3d(buff, x1,y2,z1);
    vertex_normal(buff, 0,0,-1);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[0],uvs[1]);

    vertex_position_3d(buff, x2,y2,z1);
    vertex_normal(buff, 0,0,-1);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[2],uvs[3]);
    

    vertex_position_3d(buff, x2,y2,z1);
    vertex_normal(buff, 0,0,-1);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[2],uvs[3]);

    vertex_position_3d(buff, x2,y1,z1);
    vertex_normal(buff, 0,0,-1);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[4],uvs[5]);

    vertex_position_3d(buff, x1,y1,z1);
    vertex_normal(buff, 0,0,-1);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[6],uvs[7]);
    
    global.polys+=2;
}

// base
if( tile5>=0 ){
    tile5+=TopBase;
    u = ((floor(tile5 % PerRow) * TileBorder)+border)*OneOverW;
    v = ((floor(tile5 / PerRow) * TileBorder)+border)*OneOverH;

    var c=col|(6<<26);

        
    uvs[0]=u;
    uvs[1]=v;
    uvs[2]=u+Width64;
    uvs[3]=v;
    uvs[4]=u+Width64;
    uvs[5]=v+Height64;
    uvs[6]=u;
    uvs[7]=v+Height64;
    flag = (flags>>15)&7;
    flag=4;
    if(flag!=0){
        FlipRotateTile(flag);
    } 
    

    vertex_position_3d(buff, x2,y2,z2);
    vertex_normal(buff, 0,0,-1);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[4],uvs[5]);

    vertex_position_3d(buff, x1,y2,z2);
    vertex_normal(buff, 0,0,-1);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[6],uvs[7]);
    
   vertex_position_3d(buff, x1,y1,z2);
    vertex_normal(buff, 0,0,-1);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[0],uvs[1]);


        
    vertex_position_3d(buff, x1,y1,z2);
    vertex_normal(buff, 0,0,-1);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[0],uvs[1]);

    vertex_position_3d(buff, x2,y1,z2);
    vertex_normal(buff, 0,0,-1);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[2],uvs[3]);

    vertex_position_3d(buff, x2,y2,z2);
    vertex_normal(buff, 0,0,-1);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[4],uvs[5]);
    
    global.polys+=2;
}








