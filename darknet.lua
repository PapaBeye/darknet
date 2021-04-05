project "darknetMake"
	location "%{wks.location}/vendor/darknet"
	kind "Makefile"
	language "C++"
	cppdialect "C++11"
	
	buildcommands {
		"make all -f darknet.mk -j6",
	 }
	

	cleancommands {
		"make clean",
	 }

	postbuildcommands { "cd %{prj.location} && mkdir --parents ./lib/ && cp -f ./libdarknet.so ./lib/" }
	--staticruntime "on"
	targetdir ("%{wks.location}/build/install" .. outputdir .. "/%{prj.name}")
	objdir ("%{wks.location}/build/objdir/" ..  outputdir .. "/%{prj.name}")
	files
	{
		"%{prj.location}/src/**.h",
		"%{prj.location}/include/**.h",
		"%{prj.location}/include/**.hpp",
		"%{prj.location}/src/**.hpp",
		"%{prj.location}/src/**.cpp",
		"%{prj.location}/src/**.c",
		"%{prj.location}/Makefile",
		
	}

	includedirs 
	{ 
		"%{prj.location}/include",
		
	}
	filter "configurations:Debug"
		defines "S_DEBUG"
		runtime "Debug"
		symbols "on"
	filter "configurations:Release"
		runtime "Release"
		optimize "on"