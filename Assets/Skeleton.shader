﻿Shader "Skeleton"
{
    Properties
    {
        _Color("Color", Color) = (1, 1, 1, 1)
        [Gamma] _Metallic("Metallic", Range(0, 1)) = 0
        _Glossiness("Smoothness", Range(0, 1)) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        /*
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment
            float4 Vertex(float4 position : POSITION) : SV_Position { return UnityObjectToClipPos(position); }
            float4 Fragment(float4 position : SV_Position) : SV_Target { return 1; }
            ENDCG
        }
        */

        Pass
        {
            Tags { "LightMode"="Deferred" }
            Cull Off
            CGPROGRAM
            #pragma target 5.0
            #pragma vertex Vertex
            #pragma geometry Geometry
            #pragma fragment Fragment
            #pragma multi_compile_prepassfinal noshadowmask nodynlightmap nodirlightmap nolightmap
            #include "Skeleton.hlsl"
            ENDCG
        }
        Pass
        {
            Tags { "LightMode"="ShadowCaster" }
            Cull Off
            CGPROGRAM
            #pragma target 5.0
            #pragma vertex Vertex
            #pragma geometry Geometry
            #pragma fragment Fragment
            #pragma multi_compile_prepassfinal noshadowmask nodynlightmap nodirlightmap nolightmap
            #ifndef UNITY_PASS_SHADOWCASTER
            #define UNITY_PASS_SHADOWCASTER
            #endif
            #include "Skeleton.hlsl"
            ENDCG
        }
    }
}
