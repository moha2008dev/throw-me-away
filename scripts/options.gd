extends Control

func _ready():
	$Panel/sfx.pressed = global_vars_funcs.sfx
	$"Panel/auto save".pressed = global_vars_funcs.auto_save
	$Panel/resolution.clear()
	$Panel/resolution.add_item("768 * 1024")
	$Panel/resolution.add_item("1290 * 1080")
	$Panel/screen.clear()
	$Panel/screen.add_item("fullscreen")
	$Panel/screen.add_item("windowed")
	$Panel/fps.clear()
	$Panel/fps.add_item("30 fps")
	$Panel/fps.add_item("60 fps")
	$Panel/fps.add_item("90 fps")
	
	if global_vars_funcs.resolution == 0 :
		$Panel/resolution.select(0)
	elif global_vars_funcs.resolution == 1 :
		$Panel/resolution.select(1)
		
	if global_vars_funcs.screen == 0 :
		$Panel/screen.select(0)
	elif global_vars_funcs.screen == 1 :
		$Panel/screen.select(1)
		
	match global_vars_funcs.fps :
		0 : $Panel/fps.select(0)
		1 : $Panel/fps.select(1)
		2 : $Panel/fps.select(2)
func _process(delta):
	print(global_vars_funcs.fps)
	print(global_vars_funcs.sfx)
	print(global_vars_funcs.resolution)
	print(global_vars_funcs.screen)
	print(global_vars_funcs.auto_save)
	
func _on_exit_pressed():
	Global.change_scene("res://scenes/main_menu.tscn")


func _on_sfx_toggled(button_pressed):
	global_vars_funcs.sfx = button_pressed
	global_vars_funcs.save_options()


func _on_auto_save_toggled(button_pressed):
	global_vars_funcs.auto_save = button_pressed
	global_vars_funcs.save_options()


func _on_resolution_item_selected(index):
	if index == 0 :
		global_vars_funcs.resolution = 0
	else :
		global_vars_funcs.resolution = 1
	global_vars_funcs.save_options()



func _on_screen_item_selected(index):
	if index == 0 :
		global_vars_funcs.screen = 0
	else :
		global_vars_funcs.screen = 1 
	global_vars_funcs.save_options()


func _on_fps_item_selected(index):
	match index :
		0:
			Engine.target_fps = 30
			global_vars_funcs.fps = 0
		1:
			Engine.target_fps = 60 
			global_vars_funcs.fps = 1
		2:
			Engine.target_fps = 90
			global_vars_funcs.fps = 2
	global_vars_funcs.save_options()
	


func _on_reset_pressed():
	var file = Directory.new()
	if file.file_exists("user://options.cfg"):
		file.remove("user://options.cfg")
	global_vars_funcs.load_options()
	global_vars_funcs.save_options()
	get_tree().reload_current_scene()
