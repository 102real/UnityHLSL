Shader "Custom/Holo"
{
   Properties
            {   
// Properties Block : 셰이더에서 사용할 변수를 선언하고 이를 material inspector에 노출시킵니다
            _TintColor("Color", color) = (1,1,1,1)
            _Intensity("Range Test", Range(0,1)) = 0.5
            _MainTex("RGB(A)", 2D) = "white"{}
           	}  

	SubShader
	{  

       //Render type과 Render Queue를 여기서 결정합니다.
	Tags
            {"RenderPipeline"="UniversalPipeline"
                "RenderType"="Opaque"          
                "Queue"="Geometry"
            }
    	Pass
    	{  		
     	 Name "Universal Forward"
              Tags { "LightMode" = "UniversalForward" }

       	HLSLPROGRAM

        	#pragma prefer_hlslcc gles
        	#pragma exclude_renderers d3d11_9x
        	#pragma vertex vert
        	#pragma fragment frag

//cg shader는 .cginc를 hlsl shader는 .hlsl을 include하게 됩니다.
       	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"        	
  
//vertex buffer에서 읽어올 정보를 선언합니다. 	
         	struct VertexInput
         	{
            	float4 vertex : POSITION;
                float2 uv       : TEXCOORD0;
          	};

//보간기를 통해 버텍스 셰이더에서 픽셀 셰이더로 전달할 정보를 선언합니다.
        	struct VertexOutput
          	{
           	float4 vertex  	: SV_POSITION;
            float2 uv       : TEXCOORD0;
      	};
            float _Intensity;
            half4 _TintColor;
            sampler2D _MainTex;
            float4 _MainTex_ST;
//버텍스 셰이더
      	VertexOutput vert(VertexInput v)
        	{

          	VertexOutput o;      
          	o.vertex = TransformObjectToHClip(v.vertex.xyz);
            o.uv = v.uv.xy;

         	return o;
        	}

//픽셀 셰이더
        half4 frag(VertexOutput i) : SV_Target
        {

        float2 uv = i.uv.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        //float4 color = tex2D(_MainTex, uv) *_TintColor * _Intensity;
        float4 color = tex2D(_MainTex, uv);
        return color;
       	
        	}

        	ENDHLSL  
    	}
     }
}

