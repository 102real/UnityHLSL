Shader "Custom/Holo"
{
   Properties
            {   
// Properties Block : ���̴����� ����� ������ �����ϰ� �̸� material inspector�� �����ŵ�ϴ�
           	}  

	SubShader
	{  

       //Render type�� Render Queue�� ���⼭ �����մϴ�.
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

//cg shader�� .cginc�� hlsl shader�� .hlsl�� include�ϰ� �˴ϴ�.
       	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"        	
  
//vertex buffer���� �о�� ������ �����մϴ�. 	
         	struct VertexInput
         	{
            	float4 vertex : POSITION;
          	};

//�����⸦ ���� ���ؽ� ���̴����� �ȼ� ���̴��� ������ ������ �����մϴ�.
        	struct VertexOutput
          	{
           	float4 vertex  	: SV_POSITION;
      	};

//���ؽ� ���̴�
      	VertexOutput vert(VertexInput v)
        	{

          	VertexOutput o;      
          	o.vertex = TransformObjectToHClip(v.vertex.xyz);

         	return o;
        	}

//�ȼ� ���̴�
        	half4 frag(VertexOutput i) : SV_Target
        	{ 
                 	
          	return half4(0.5 , 0.5, 0.5, 1);  
       	
        	}

        	ENDHLSL  
    	}
     }
}
