extends Control
@onready var playercamera2d = $Player/Camera2D
@onready var player = $Player
@onready var levels = "res://Scenes/levels.tscn"

func _ready():
	BackgroundSong.place = "Lobby"
	player.world_name = "START_SCENE"
	playercamera2d.enabled = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
func _process(_delta):
	player.global_position.x = clamp(player.global_position.x,0,576)
	player.global_position.y = clamp(player.global_position.y,0,327)
	#if Input.is_action_just_pressed("Restart") :
		#get_tree().reload_current_scene()




func _on_button_pressed():
	get_tree().change_scene_to_file(levels)
