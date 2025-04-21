extends Node2D
@export_file("*tscn") var current_level : String
@export var Map_Length : int
@export var Level_Now : int
@export_file("*tscn") var next_level : String
@onready var spawn_pos : Vector2
@onready var check_point__start = $"Background/Accessories/CheckPoint_ Start"
@onready var player = $Player
@onready var parallax_layer = $Background/CanvasLayer/ParallaxBackground/ParallaxLayer
@onready var ui = $Background/CanvasLayer/UI
@onready var playercamera2d = $Player/Camera2D
@onready var comparison
func _ready():
	read_data()
	Gvar.level = current_level
	BackgroundSong.place = "World"
	player.world_name = "WORLD"
	playercamera2d.enabled = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	spawn_pos = check_point__start.set_start_pos()
	player.ready_start_pos(spawn_pos)
	ui.read_data()

func read_data() :
	var opendirreadlevel = FileAccess.open("user://JourneyLevel", FileAccess.READ)
	if opendirreadlevel != null :
		comparison = opendirreadlevel.get_32()
		#print(comparison)
	else:
		comparison = 1
		#print(comparison)

func save_data() :
	if comparison < Level_Now :
		var opendirsavelevel = FileAccess.open("user://JourneyLevel", FileAccess.WRITE)
		opendirsavelevel.store_32(Level_Now)
		#print(Level_Now)

		
func _process(_delta):
	player.global_position.x = clamp(player.global_position.x,0, Map_Length)
	player.global_position.y = clamp(player.global_position.y,0,414)
	playercamera2d.limit_right = Map_Length
	playercamera2d.limit_bottom = 413
	
	#if Input.is_action_just_pressed("Restart") :
		#get_tree().reload_current_scene()

func _on_player_playerdie():
	ui.playerdie()
	#print("playerdie")


func _on_ui_zero_love():
	player.explode()
	#print("zero love")



func _on_player_playercoin():
	ui.player_get_coin()
	#print("player coin")

func _on_player_playerdiamond():
	ui.player_get_diamond()
	#print("player diamond")



func _on_check_point__exit_body_entered(body):
	if body.name == "Player" :
		ui.save_data()
		call_deferred("change_level")

func change_level() :
	save_data()
	get_tree().change_scene_to_file(next_level)
