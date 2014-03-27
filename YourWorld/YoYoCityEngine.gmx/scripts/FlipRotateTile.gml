/// FlipRotateTile(flags)
//  Flips and rotates the instance uv[] array
//  bit 0= Flip-Vertical
//  bit 1= Flip-Horizontal
//  bit 2= Rotate 90


var tu1,tu2,tu3,tu4;

// rotate 90?
if( (argument0&4)!=0)
{
    tu1 = uvs[6];
    tu2 = uvs[7];

    uvs[6] = uvs[4];
    uvs[7] = uvs[5];
    uvs[4] = uvs[2];
    uvs[5] = uvs[3];
    uvs[2] = uvs[0];
    uvs[3] = uvs[1];
    uvs[0] = tu1;
    uvs[1] = tu2;
}


// Flip-Vertical?
if( (argument0&1)!=0)
{
    tu1 = uvs[0];
    tu2 = uvs[1];
    tu3 = uvs[2];
    tu4 = uvs[3];

    uvs[0] = uvs[6];
    uvs[1] = uvs[7];
    uvs[2] = uvs[4];
    uvs[3] = uvs[5];
    uvs[6] = tu1;
    uvs[7] = tu2;
    uvs[4] = tu3;
    uvs[5] = tu4;
}

// Flip-Horizontal?
if( (argument0&2)!=0)
{
    tu1 = uvs[0];
    tu2 = uvs[1];
    tu3 = uvs[6];
    tu4 = uvs[7];

    uvs[0] = uvs[2];
    uvs[1] = uvs[3];
    uvs[6] = uvs[4];
    uvs[7] = uvs[5];
    uvs[2] = tu1;
    uvs[3] = tu2;
    uvs[4] = tu3;
    uvs[5] = tu4;
}


