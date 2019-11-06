//--------------------------------------------------------------------------------------
// By Stars XU Tianchen
//--------------------------------------------------------------------------------------

#include "UpSample.hlsli"

//--------------------------------------------------------------------------------------
// Textures
//--------------------------------------------------------------------------------------
Texture2D<float3>	g_txSource;
Texture2D<float3>	g_txCoarser;
RWTexture2D<float3>	g_txDest;

//--------------------------------------------------------------------------------------
// Compute shader
//--------------------------------------------------------------------------------------
[numthreads(8, 8, 1)]
void main(uint2 DTid : SV_DispatchThreadID)
{
	float2 dim;
	g_txDest.GetDimensions(dim.x, dim.y);

	// Fetch the color of the current level and the resolved color at the coarser level
	const float2 tex = (DTid + 0.5) / dim;
	const float3 src = g_txSource.SampleLevel(g_smpLinear, tex, 0.0);
	const float3 coarser = g_txCoarser.SampleLevel(g_smpLinear, tex, 0.0);

	const float4 result = UpSample(tex, coarser);

	g_txDest[DTid] = lerp(result.xyz, src, result.w);
}
