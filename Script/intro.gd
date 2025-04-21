extends Control
@onready var start_scene = "res://Scenes/start_scene.tscn"
func _ready():
	BackgroundSong.place = "Lobby"
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
func _process(_delta):
	await get_tree().create_timer(5.0).timeout
	get_tree().change_scene_to_file(start_scene)
