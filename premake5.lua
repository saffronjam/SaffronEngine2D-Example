---@diagnostic disable: undefined-global

function MainRelative(path)
   return _MAIN_SCRIPT_DIR .. "/" .. path
end

function CopyFoldCmd(src, dst)
   return '{COPY} "' .. src .. '" "' .. dst .. '"'
end

OutputDirectory = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}/"

ProjectName = "Project"

workspace (ProjectName)
   architecture "x64"
   configurations { "Debug", "Release", "Dist" }

SaffronEngine2D = require("ThirdParty.SaffronEngine2D.premake5")

   flags {
      SaffronEngine2D.Flags
   }

project (ProjectName)
   kind "ConsoleApp"
   language "C++"
   cppdialect "c++20"
	staticruntime "On"

	targetdir (MainRelative("/Build/Bin/") .. OutputDirectory .. "%{prj.name}")
	objdir (MainRelative("/Build/Obj/") .. OutputDirectory .. "%{prj.name}")

   location "Build"

   files{
      "Source/**.h", 
      "Source/**.c", 
      "Source/**.hpp", 
      "Source/**.cpp",
   }

   includedirs {
      SaffronEngine2D.Include,
      "Source"
   }

   links {
      SaffronEngine2D.Project
   }

   defines {
      SaffronEngine2D.Defines
   }

   postbuildcommands
   {
      CopyFoldCmd(MainRelative("Assets"), MainRelative("Build/Bin/Debug-windows-x86_64/Project/Assets")),
      CopyFoldCmd(MainRelative("Assets"), MainRelative("Build/Assets")),
      CopyFoldCmd(MainRelative("imgui.ini"), MainRelative("Build/Bin/Debug-windows-x86_64/Project/imgui.ini")),
      CopyFoldCmd(MainRelative("imgui.ini"), MainRelative("Build/")),
      CopyFoldCmd(MainRelative("ThirdParty/SaffronEngine2D/ThirdParty/SFML/Bin/msvc/Debug"), MainRelative("Build/Bin/Debug-windows-x86_64/Project"))
   }

   filter "configurations:Debug"
      defines { "DEBUG", "SE_DEBUG" }
      symbols "On"

   filter "configurations:Release"
      defines { "NDEBUG", "SE_RELEASE" }
      optimize "On"

   filter "configurations:Dist"
      defines { "NDEBUG", "SE_DIST" }
      optimize "On"