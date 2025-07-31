extends Node

var sfx = false 
var auto_save = true
var resolution = 0 # 0 = 768 * 1024 /1 = 1920 * 1080
var screen = 0 # 0 = fullscreen/1 = windowed 
var fps = 0  # 0= 30fps / 1= 60fps / 2= 90fps


func save_options():
	var config = ConfigFile.new()
	config.set_value("music","sfx",sfx)
	config.set_value("game","auto_save",auto_save)
	config.set_value("settings","fps",fps)
	config.set_value("game","resolution",resolution)
	config.set_value("game","screen",screen)
	config.save("user://options.cfg")
	
func load_options():
	var config = ConfigFile.new()
	var err = config.load("user://options.cfg")
	if err == OK :
		config.get_value("music","sfx",sfx)
		config.get_value("game","auto_save",auto_save)
		config.get_value("settings","fps",fps)
		config.get_value("game","resolution",resolution)
		config.get_value("game","screen",screen)
	else:
		sfx = false 
		auto_save = true
		resolution = 0 # 0 = 768 * 1024 /1 = 1920 * 1080
		screen = 0 # 0 = fullscreen/1 = windowed 
		fps = 0  # 0= 30fps / 1= 60fps / 2= 90fps
