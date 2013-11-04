//
// HLSL 9 City Rendering Shader
//
struct VS_INPUT
{
    float4  Position        : POSITION;
    float3  Normal          : NORMAL;
    float4  Colour          : COLOR0;
    float2  TextureCoord    : TEXCOORD0;
};

struct VS_OUTPUT
{
    float4  Pos             : POSITION;
    float4  Colour          : COLOR;
    float2  Tex0            : TEXCOORD0;
    float3  ViewSpaceNormal : TEXCOORD1;
};

/////////////////////////////////////////////////////////

VS_OUTPUT main(VS_INPUT In)
{
    VS_OUTPUT Out;
    
    Out.Pos     = mul(gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION], In.Position);
    Out.Tex0    = In.TextureCoord;
    Out.Colour  = In.Colour;
    
    float4 objspacenormal4  = float4(In.Normal, 0.0);
    float3 viewspacenormal  = mul(gm_Matrices[MATRIX_WORLD_VIEW], objspacenormal4).xyz;
    Out.ViewSpaceNormal     = (viewspacenormal * float3(0.5, 0.5, 0.5)) + float3(0.5, 0.5, 0.5);
    
    return Out;
}
//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// HLSL City pixel shader
//

struct PS_INPUT
{
    float4  Colour              : COLOR0;
    float2  Tex0                : TEXCOORD0;
    float3  ViewSpaceNormal     : TEXCOORD1;
};

struct PS_OUTPUT
{
    float4  Colour              : COLOR0;
    float4  SelectionID         : COLOR1;
};

////////////////////////////////////////////////////////////////

PS_OUTPUT main(PS_INPUT In)
{
    PS_OUTPUT Out = (PS_OUTPUT) 0;
    
    Out.Colour = tex2D(gm_BaseTexture, In.Tex0);//In.Colour;
    Out.SelectionID = float4(In.ViewSpaceNormal, 1.0);
    
    return Out;
}
