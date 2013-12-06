//
// Simple sprite shader (HLSL9)
//
struct SInput { //in from attributes to vertex
    float4 Position : POSITION;
    float4 Colour   : COLOR0;
    float2 Texcoord : TEXCOORD0;
};
  
struct SOutput { //out from vertex to pixel
    float4 Position : POSITION;
    float4 Colour   : COLOR0;
    float2 Texcoord : TEXCOORD0;
};


void main(in SInput IN, out SOutput OUT)
{
    OUT.Position = mul(gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION], IN.Position); 
    OUT.Colour = IN.Colour;
    OUT.Texcoord = IN.Texcoord;
}
//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple sprite shader (HLSL9)
//
struct SInput { //in from vertex to pixel
    float4 Colour    : COLOR0;
    float2 Texcoord : TEXCOORD0;
};

struct SOutput { //out from pixel to screen
    float4 Colour[2]   : COLOR;
};
  
void main(in SInput IN, out SOutput OUT)
{
    float4 Texture = tex2D(gm_BaseTexture, IN.Texcoord.xy);
    OUT.Colour[0] = Texture;
    OUT.Colour[1] = IN.Colour;
    // Do alpha test (not available as a global state in WebGL)
    if (OUT.Colour[0].a < ((1.0/255.0)*5.0) ) discard; //<= (1.0/253.0)) discard;    
    
} 
