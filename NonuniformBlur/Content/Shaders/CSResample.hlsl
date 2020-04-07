//--------------------------------------------------------------------------------------
// Copyright (c) XU, Tianchen. All rights reserved.
//--------------------------------------------------------------------------------------

#include "Resample.hlsli"

//--------------------------------------------------------------------------------------
// Textures
//--------------------------------------------------------------------------------------
RWTexture2D<float4>	g_txDest;

//--------------------------------------------------------------------------------------
// Compute shader
//--------------------------------------------------------------------------------------
[numthreads(8, 8, 1)]
void main(uint2 DTid : SV_DispatchThreadID)
{
	float2 imageSize;
	g_txDest.GetDimensions(imageSize.x, imageSize.y);

	const float2 tex = (DTid + 0.5) / imageSize;

	g_txDest[DTid] = Resample(tex);
}
