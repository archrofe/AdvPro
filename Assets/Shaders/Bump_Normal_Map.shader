﻿Shader "Lesson/Bump/Albedo" //Shader Component menu name if we click on
//Shader > Lesson we will find the shader named Albedo
//shader is written in 2 languages
//HLSL - high level shader language - input
//Cg - C for graphics - output
//base of the shader is written in HLSL
//and the body is Cg
{
	Properties
		//Properties
		//is written in HLSL
		//it does not end with a ;
		//this is also your inspector variables
		//and the input of data into the script
	{
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		//our variable is called _MainTex
		//our Display name is the inspector is Albedo (RGB)
		//it is a 2D variable type, meanign it is an image
		//default colour if we have no image
		_BumpMap ("Normal Map", 2D) = "bump" {}
		//Input the bump map is still an image
		//"bump" - tells the program this needs to be a normal map
	}
		SubShader //you can hava multiple sub shaders
			//sub shaders are written in HLSL
			// but have Cg contained as the body
			//the multiple shaders allow you to render levels of detail
			//they run at different GPU levels in a platform
	{
		Tags //reference to the type of rendering
		{
			"RenderType" = "Opaque"
		}
			LOD 200 //this is the level of Detail
			///////////////
			CGPROGRAM	//THIS IS WHERE Cg Code starts
			//////////////
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface mainColour Lambert
		/*
		this tells us that the surface of our model
		is affected by the mainColour Funtion
		the material type is Lambert
		meaning the material is flat and has no highlights
		*/
		sampler2D _MainTex;
		//this is the 2D texture variable in Cg
		sampler2D _BumpMap;
		struct Input //allows us to get the UV map of our model
		{
			float2 uv_MainTex;
			//uv maps are Vector 2's X and Y
			//because Vector 2 has 2 input numbers we are using a float 2 which gives us 2 floats
			//maps our tecture map to the uv map
			//makes sure each pixel is in the right place
			float2 uv_BumpMap;
		};
		void mainColour(Input modelsTextureInput, inout SurfaceOutput renderedOutput)
		//mainColour Function as referenced above
		{
			renderedOutput.Albedo = tex2D(_MainTex, modelsTextureInput.uv_MainTex).rgb;
			//Albedo is our base colour with out reflection or highlights
			// we are setting the surface to of the model to the colour of our 2D texture
			//according to the UV map and the RGB (Red Green Blue)
			renderedOutput.Normal = UnpackNormal(tex2D(_BumpMap, modelsTextureInput.uv_BumpMap));
		}
		//////////
		ENDCG	//THIS IS WHERE Cg Code ends
		//////////
	}
		FallBack "Diffuse"
		//we replace it with Diffuse which is a flat 1 Texture shader
		//default
}
