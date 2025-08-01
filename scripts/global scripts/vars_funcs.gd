extends Node

var sfx = true 
var vsync = true
var show_fps = false
var resolution = 0
var screen = 0 
var fps = 0 

var resolutions : Array = [Vector2(1280, 720),Vector2(1366, 768),Vector2(1600, 900),Vector2(1920, 1080)]

func _ready():
	if !resolutions.has(OS.get_screen_size()):
		resolutions.append(OS.get_screen_size())
		resolutions.sort()
	resolution = resolutions.size()-1
	load_options()

func save_options():
	var config = ConfigFile.new()
	config.set_value("sound","sfx",sfx)
	config.set_value("game","vsync",vsync)
	config.set_value("settings","fps",fps)
	config.set_value("game","resolution",resolution)
	config.set_value("game","screen",screen)
	apply_options()
	config.save("user://options.cfg")

func load_options():
	var config = ConfigFile.new()
	var err = config.load("user://options.cfg")
	if err == OK :
		sfx = config.get_value("sound","sfx",sfx)
		vsync = config.get_value("game","vsync",vsync)
		fps = config.get_value("settings","fps",fps)
		resolution = config.get_value("game","resolution",resolution)
		screen = config.get_value("game","screen",screen)
		apply_options()
	else:
		sfx = true
		vsync = true
		resolution = resolutions.size()-1
		screen = 0
		fps = 0

func apply_options():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), !sfx)
	match screen:
		0:
			OS.window_fullscreen = true
		1:
			OS.window_fullscreen = false
			OS.window_borderless = true
			OS.window_size = OS.get_screen_size()
			resolution = resolutions.find(OS.get_screen_size())
			OS.window_position = Vector2()
		2:
			OS.window_fullscreen = false
			OS.window_borderless = false
	OS.window_size = resolutions[resolution]
	OS.vsync_enabled = vsync
	OS.window_position = (OS.get_screen_size()-OS.window_size)/2
	match fps:
		0:
			Engine.target_fps = 0
		1:
			Engine.target_fps = 30
		2:
			Engine.target_fps = 60 
		3:
			Engine.target_fps = 144
	Global.show_fps(show_fps)
