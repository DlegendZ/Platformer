extends Control
@onready var parallax_background = $CanvasLayer/ParallaxBackground
@onready var texture_button = $Level_number/Level_1/TextureButton
@onready var current_level : int
@onready var level_1 = "res://Scenes/World.tscn"
@onready var level_2 = "res://Scenes/level_2.tscn"
@onready var level_3 = "res://Scenes/level_3.tscn"
@onready var level_4 = "res://Scenes/level_4.tscn"
@onready var level_5 = "res://Scenes/level_5.tscn"
@onready var level_6 = "res://Scenes/level_6.tscn"
@onready var level_7 = "res://Scenes/level_7.tscn"
@onready var level_8 = "res://Scenes/level_8.tscn"
@onready var level_dictionary = {
	"level_1" : $Level_number/Level_1, 
	"level_2" : $Level_number/Level_2, 
	"level_3" : $Level_number/Level_3, 
	"level_4" : $Level_number/Level_4, 
	"level_5" : $Level_number/Level_5,
	"level_6" : $Level_number/Level_6,
	"level_7" : $Level_number/Level_7,
	"level_8" : $Level_number/Level_8
	}
@onready var level_keyword 
@onready var current_global_level
func _ready(): 
	read_data()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	for i in range(1, current_level + 1) :
		level_keyword = "level_"+ str(i)
		current_global_level = level_dictionary[level_keyword]
		current_global_level.visible = true


func read_data() :
	var opendir = FileAccess.open("user://JourneyLevel", FileAccess.READ)
	if opendir != null :
		current_level = opendir.get_32()
		#print(current_level)
	else :
		current_level = 1
	
func _process(delta):
	BackgroundSong.place = "Lobby"
	parallax_background.scroll_base_offset -= Vector2(20 * delta, 20 * delta)
	
func _on_texture_button_pressed_level_1():
	get_tree().change_scene_to_file(level_1)

func _on_texture_button_pressed_level_2():
	get_tree().change_scene_to_file(level_2)

func _on_texture_button_pressed_level_3():
	get_tree().change_scene_to_file(level_3)

func _on_texture_button_pressed_level_4():
	get_tree().change_scene_to_file(level_4)

func _on_texture_button_pressed_level_5():
	get_tree().change_scene_to_file(level_5)

func _on_texture_button_pressed_level_6():
	get_tree().change_scene_to_file(level_6)
	
func _on_texture_button_pressed_level_7():
	get_tree().change_scene_to_file(level_7)
	
func _on_texture_button_pressed_level_8():
	get_tree().change_scene_to_file(level_8)
