	function findOpenGL()
		configuration{}
		if os.is("Linux") then
			return true
		end
		--assume OpenGL is available on Mac OSX, Windows etc
		return true
	end

	function initOpenGL()
		configuration {}
		configuration {"Windows"}
			links {"opengl32","glu32"}
		configuration {"MacOSX"}
 			links { "OpenGL.framework"} 
		configuration {"not Windows", "not MacOSX"}
			if os.isdir("/usr/include") and os.isfile("/usr/include/GL/gl.h") then
				links {"GL","GLU"}
			else
				print("No GL/gl.h found, using dynamic loading of GL using glew")
				defines {"GLEW_INIT_OPENGL11_FUNCTIONS=1"}
				links {"dl"}
			end
		configuration{}
	end

	function initGlut()
		configuration {}
		if os.is("Windows") then
			configuration {"Windows"}
			includedirs {
				projectRootDir .. "btgui/OpenGLWindow/Glut"
			}
			libdirs { projectRootDir .. "btgui/OpenGLWindow/Glut"}
			configuration {"Windows", "x32"}
				links {"glut32"}
			configuration {"Windows", "x64"}
				links {"glut64"}
		end
		
		configuration {"MacOSX"}
 			links { "Glut.framework" } 
		configuration {"Linux"}
			links {"glut"}
		configuration{}
	end

	function initGlew()
		configuration {}
		if os.is("Windows") then
			configuration {"Windows"}
			defines { "GLEW_STATIC"}
			includedirs {
					projectRootDir .. "btgui/OpenGLWindow/GlewWindows"
			}
			files { projectRootDir .. "btgui/OpenGLWindow/GlewWindows/glew.c"}
		end
		if os.is("Linux") then
			configuration{"Linux"}
			--if os.isdir("/usr/include") and os.isfile("/usr/include/GL/glew.h") then 
		--		links {"GLEW"}
		--	else
				--print("Using static glew and dynamic loading of glx functions")
			 	defines { "GLEW_STATIC","GLEW_DYNAMIC_LOAD_ALL_GLX_FUNCTIONS=1"}
                        	includedirs {
                                        projectRootDir .. "btgui/OpenGLWindow/GlewWindows"
                        	}
                        	files { projectRootDir .. "btgui/OpenGLWindow/GlewWindows/glew.c"}
		--	end

		end
		configuration{}
	end

	function initX11()
		if os.is("Linux") then
			if os.isdir("/usr/include") and os.isfile("/usr/include/X11/X.h") then
				links{"X11","pthread"}
			else
				print("No X11/X.h found, using dynamic loading of X11")
				includedirs {
                                        projectRootDir .. "btgui/OpenGLWindow/optionalX11"
                                }
				defines {"DYNAMIC_LOAD_X11_FUNCTIONS"}	
				links {"dl","pthread"}
			end
		end
	end

