/// Add a cube to a mesh
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


// get textel sizes based on the tile+border size
var PerRow = floor(sprite_get_width(StyleSprite)/TileBorder);     // Number of tiles per row
var border = (TileBorder - TileSize)/2;
var OneOverW  = 1.0/sprite_get_width(StyleSprite);
var OneOverH = 1.0/sprite_get_height(StyleSprite);
var Width64  = (1.0/sprite_get_width(StyleSprite))*(TileSize-1);
var Height64 = (1.0/sprite_get_height(StyleSprite))*(TileSize-1);

var u,v;

// Keep these in the instance, so they aren't copied inside functions
uvs=0;

// top
if( tile0>=0 ){
    u = (floor(tile0 % PerRow) * TileBorder)*OneOverW + (OneOverW*border);
    v = (floor(tile0 / PerRow) * TileBorder)*OneOverH + (OneOverH*border);
    
    var c=col|(1<<26);
    
    uvs[0]=u+Width64;
    uvs[1]=v;
    uvs[2]=u+Width64;
    uvs[3]=v+Height64;
    uvs[4]=u;
    uvs[5]=v+Height64;
    uvs[6]=u;
    uvs[7]=v;
    if(flags&(1<<21)!=0){
        uvs = Flip_tile_UD(uvs);
    }    
    
    vertex_position_3d(buff, x1,y2,z1);
    vertex_normal(buff, 0,1,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[0],uvs[1]);

    vertex_position_3d(buff, x1,y2,z2);
    vertex_normal(buff, 0,1,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[2],uvs[3]);

    vertex_position_3d(buff, x2,y2,z2);
    vertex_normal(buff, 0,1,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[4],uvs[5]);
    

    vertex_position_3d(buff, x2,y2,z2);
    vertex_normal(buff, 0,1,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[4],uvs[5]);

    vertex_position_3d(buff, x2,y2,z1);
    vertex_normal(buff, 0,1,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[6],uvs[7]);

    vertex_position_3d(buff, x1,y2,z1);
    vertex_normal(buff, 0,1,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[0],uvs[1]);

    global.polys+=2;
}



// bottom
if( tile1>=0 ){
    u = (floor(tile1 % PerRow) * TileBorder)*OneOverW + (OneOverW*border);
    v = (floor(tile1 / PerRow) * TileBorder)*OneOverH + (OneOverH*border);
    
    var c=col|(2<<26);
    
    uvs[0]=u;
    uvs[1]=v;
    uvs[2]=u+Width64;
    uvs[3]=v;
    uvs[4]=u+Width64;
    uvs[5]=v+Height64;
    uvs[6]=u;
    uvs[7]=v+Height64;
    var flatlr=flags&(1<<7);
    if(flags&(1<<21)!=0){
        uvs = Flip_tile_LR(uvs);
    }        
    if(flatlr!=0){
        uvs = Flip_tile_LR(uvs);
    }

    if( flatlr == 0 ){
        vertex_position_3d(buff, x1,y1,z1);
    }else{
        vertex_position_3d(buff, x1,y2,z1);
    }
    vertex_normal(buff, 0,-1,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[0],uvs[1]);

    if( flatlr == 0 ){
        vertex_position_3d(buff, x2,y1,z1);
    }else{
        vertex_position_3d(buff, x2,y2,z1);
    }
    vertex_normal(buff, 0,-1,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[2],uvs[3]);

    if( flatlr == 0 ){
        vertex_position_3d(buff, x2,y1,z2);
    }else{
        vertex_position_3d(buff, x2,y2,z2);
    }
    vertex_normal(buff, 0,-1,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[4],uvs[5]);
    
    
    

    if( flatlr == 0 ){
        vertex_position_3d(buff, x2,y1,z2);
    }else{
        vertex_position_3d(buff, x2,y2,z2);    
    }
    vertex_normal(buff, 0,-1,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[4],uvs[5]);

    if( flatlr == 0 ){
        vertex_position_3d(buff, x1,y1,z2);
    }else{
        vertex_position_3d(buff, x1,y2,z2);
    }
    vertex_normal(buff, 0,-1,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[6],uvs[7]);

    if( flatlr == 0 ){
        vertex_position_3d(buff, x1,y1,z1);
    }else{
        vertex_position_3d(buff, x1,y2,z1);
    }
    vertex_normal(buff, 0,-1,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[0],uvs[1]);

    global.polys+=2;
}



// left
if( tile2>=0 ){
    u = (floor(tile2 % PerRow) * TileBorder)*OneOverW + (OneOverW*border);
    v = (floor(tile2 / PerRow) * TileBorder)*OneOverH + (OneOverH*border);
    
    var c=col|(3<<26);
    
    uvs[0]=u+Width64;
    uvs[1]=v;
    uvs[2]=u+Width64;
    uvs[3]=v+Height64;
    uvs[4]=u;
    uvs[5]=v+Height64;
    uvs[6]=u;
    uvs[7]=v;
    
    if(flags&(1<<22)!=0){
        uvs = Flip_tile_UD(uvs);
    }
        
    vertex_position_3d(buff, x1,y1,z1);
    vertex_normal(buff, -1,0,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[0],uvs[1]);

    vertex_position_3d(buff, x1,y1,z2);
    vertex_normal(buff, -1,0,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[2],uvs[3]);

    vertex_position_3d(buff, x1,y2,z2);
    vertex_normal(buff, -1,0,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[4],uvs[5]);
    

    vertex_position_3d(buff, x1,y2,z2);
    vertex_normal(buff, -1,0,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[4],uvs[5]);

    vertex_position_3d(buff, x1,y2,z1);
    vertex_normal(buff, -1,0,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[6],uvs[7]);

    vertex_position_3d(buff, x1,y1,z1);
    vertex_normal(buff, -1,0,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[0],uvs[1]);
    
    global.polys+=2;
}


// right
if( tile3>=0 ){
    u = (floor(tile3 % PerRow) * TileBorder)*OneOverW + (OneOverW*border);
    v = (floor(tile3 / PerRow) * TileBorder)*OneOverH + (OneOverH*border);
    
    var c=col|(4<<26);
        
    uvs[0]=u+Width64;
    uvs[1]=v;
    uvs[2]=u;
    uvs[3]=v;
    uvs[4]=u;
    uvs[5]=v+Height64;
    uvs[6]=u+Width64;
    uvs[7]=v+Height64;

    var flatlr=flags&(1<<7);   
    if(flags&(1<<22)!=0){
        uvs = Flip_tile_LR(uvs);
    }

    // flatten right face onto left? (signs, fences etc.)
    if(flatlr==0){
        vertex_position_3d(buff, x2,y1,z1);
    }else{
        vertex_position_3d(buff, x1,y1,z1);
    }
    vertex_normal(buff, 1,0,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[0],uvs[1]);

    if(flatlr==0){
        vertex_position_3d(buff, x2,y2,z1);
    }else{
        vertex_position_3d(buff, x1,y2,z1);
    }
    vertex_normal(buff, 1,0,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[2],uvs[3]);

    if(flatlr==0){
        vertex_position_3d(buff, x2,y2,z2);
    }else{
        vertex_position_3d(buff, x1,y2,z2); 
    }
    vertex_normal(buff, 1,0,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[4],uvs[5]);
    

    
    
    if(flatlr==0){
        vertex_position_3d(buff, x2,y2,z2);
    }else{
        vertex_position_3d(buff, x1,y2,z2); 
    }
    vertex_normal(buff, 1,0,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[4],uvs[5]);

    if(flatlr==0){
        vertex_position_3d(buff, x2,y1,z2);
    }else{
        vertex_position_3d(buff, x1,y1,z2);
    }
    vertex_normal(buff, 1,0,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[6],uvs[7]);

    if(flatlr==0){
        vertex_position_3d(buff, x2,y1,z1);
    }else{
        vertex_position_3d(buff, x1,y1,z1);
    }
    vertex_normal(buff, 1,0,0);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[0],uvs[1]);
    
    global.polys+=2;
}



// front (lid)
if( tile4>=0 ){
    tile4+=TopBase;
    u = (floor(tile4 % PerRow) * TileBorder)*OneOverW + (OneOverW*border)+ (OneOverW/2);
    v = (floor(tile4 / PerRow) * TileBorder)*OneOverH + (OneOverH*border)+ (OneOverH/2);

    var c=col|(5<<26);

    uvs[0]=u;
    uvs[1]=v;
    uvs[2]=u+Width64;
    uvs[3]=v;
    uvs[4]=u+Width64;
    uvs[5]=v+Height64;
    uvs[6]=u;
    uvs[7]=v+Height64;
    //uvs = Rotate_tile(uvs,flags&~((3<<16))<<5);
    // 0=none, 1=90, 2=180, 3=270
    var rot=((flags&~((3<<16))<<5)>>14)&3;
    if(rot!=3){
        rot = 3-rot;
        for(var i=0;i<rot;i++){
            var tu1 = uvs[0];
            var tu2 = uvs[1];
        
            uvs[0] = uvs[2];
            uvs[1] = uvs[3];
            uvs[2] = uvs[4];
            uvs[3] = uvs[5];
            uvs[4] = uvs[6];
            uvs[5] = uvs[7];
            uvs[6] = tu1;
            uvs[7] = tu2;
        }
    }
    
    
    vertex_position_3d(buff, x1,y1,z1);
    vertex_normal(buff, 0,0,-1);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[0],uvs[1]);

    vertex_position_3d(buff, x1,y2,z1);
    vertex_normal(buff, 0,0,-1);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[2],uvs[3]);

    vertex_position_3d(buff, x2,y2,z1);
    vertex_normal(buff, 0,0,-1);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[4],uvs[5]);
    

    vertex_position_3d(buff, x2,y2,z1);
    vertex_normal(buff, 0,0,-1);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[4],uvs[5]);

    vertex_position_3d(buff, x2,y1,z1);
    vertex_normal(buff, 0,0,-1);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[6],uvs[7]);

    vertex_position_3d(buff, x1,y1,z1);
    vertex_normal(buff, 0,0,-1);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[0],uvs[1]);
    
    global.polys+=2;
}

// front (lid)
if( tile5>=0 ){
    tile4+=TopBase;
    u = (floor(tile4 % PerRow) * TileBorder)*OneOverW + (OneOverW*border)+ (OneOverW/2);
    v = (floor(tile4 / PerRow) * TileBorder)*OneOverH + (OneOverH*border)+ (OneOverH/2);

    var c=col|(6<<26);

    uvs[0]=u;
    uvs[1]=v;
    uvs[2]=u+Width64;
    uvs[3]=v;
    uvs[4]=u+Width64;
    uvs[5]=v+Height64;
    uvs[6]=u;
    uvs[7]=v+Height64;
    //uvs = Rotate_tile(uvs,flags&~((3<<16))<<5);
    // 0=none, 1=90, 2=180, 3=270
    var rot=((flags&~((3<<16))<<5)>>14)&3;
    if(rot!=3){
        rot = 3-rot;
        for(var i=0;i<rot;i++){
            var tu1 = uvs[0];
            var tu2 = uvs[1];
        
            uvs[0] = uvs[2];
            uvs[1] = uvs[3];
            uvs[2] = uvs[4];
            uvs[3] = uvs[5];
            uvs[4] = uvs[6];
            uvs[5] = uvs[7];
            uvs[6] = tu1;
            uvs[7] = tu2;
        }
    }
    

    vertex_position_3d(buff, x2,y2,z2);
    vertex_normal(buff, 0,0,-1);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[4],uvs[5]);

    vertex_position_3d(buff, x1,y2,z2);
    vertex_normal(buff, 0,0,-1);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[2],uvs[3]);
    
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
    vertex_texcoord(buff, uvs[6],uvs[7]);

    vertex_position_3d(buff, x2,y2,z2);
    vertex_normal(buff, 0,0,-1);
    vertex_argb(buff,c);
    vertex_texcoord(buff, uvs[4],uvs[5]);
    
    global.polys+=2;
}


global.cubes++;







