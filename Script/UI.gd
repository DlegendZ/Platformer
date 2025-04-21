extends Control
signal ZeroLove
@onready var love_shape = 4
@onready var texture_file : CompressedTexture2D
@onready var love_1 = $"Love 1"
@onready var love_2 = $"Love 2"
@onready var love_3 = $"Love 3"
@onready var love_turn = 3
@onready var love_keyword
@onready var current_love_nodes
@onready var coin_sum
@onready var label_diamond = $Node_Diamond/Label
@onready var label_coin= $"Node _ Coins/Label"
@onready var diamond_sum
@onready var panel_stuffs = $Settings/Panel_stuffs
@onready var shop = "res://Scenes/shopping.tscn"
@onready var button_pressed = $Button_pressed
@onready var level = "res://Scenes/levels.tscn"
@onready var main_menu = "res://Scenes/start_scene.tscn"
@onready var love_nodes = {"love_1" : love_1, "love_2" : love_2, "love_3" : love_3}
@onready var alive = true

func save_data() :
	#print("save_data")
	var opendirdiamond = FileAccess.open("user://JourneyDiamond", FileAccess.WRITE)
	var opendircoin = FileAccess.open("user://JourneyCoin", FileAccess.WRITE)
	opendircoin.store_32(coin_sum)
	opendirdiamond.store_32(diamond_sum)

func read_data() :
	#print("read_data")
	var data_dir_coin = FileAccess.open("user://JourneyCoin", FileAccess.READ)
	var data_dir_diamond = FileAccess.open("user://JourneyDiamond", FileAccess.READ)
	if data_dir_coin != null and data_dir_diamond != null :
		coin_sum = data_dir_coin.get_32()
		diamond_sum = data_dir_diamond.get_32()
	else :
		coin_sum = 0
		diamond_sum = 0
	Gvar.globalcoin = coin_sum
	Gvar.globaldiamond = diamond_sum
	label_coin.text = "x " + str(coin_sum)
	label_diamond.text = "x " + str(diamond_sum)
	

func playerdie() :
	if alive == true :
		if love_shape < 6 :
			love_shape += 1
		elif love_shape == 6 :
			love_turn -= 1 
			love_shape = 5
		#print(str(love_shape)+","+str(love_turn))
		love_keyword = "love_" + str(love_turn)
		current_love_nodes = love_nodes[love_keyword]
		texture_file = load("res://Assets/Tiles/tile_004"+ str(love_shape) + ".png")
		current_love_nodes.texture = texture_file
		if love_shape == 6 and love_turn == 1 :
			emit_signal("ZeroLove")
			love_1.texture = load("res://Assets/Tiles/tile_0046.png")
			love_2.texture = load("res://Assets/Tiles/tile_0046.png")
			love_3.texture = load("res://Assets/Tiles/tile_0046.png")
			alive = false

		
func player_get_coin():
	coin_sum += 1 
	label_coin.text = "x " + str(coin_sum)
	
func player_get_diamond():
	diamond_sum += 1
	label_diamond.text = "x " + str(diamond_sum)


func _on_texture_button_pressed():
	button_pressed.play()
	if panel_stuffs.visible == false :
		panel_stuffs.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else :
		panel_stuffs.visible = false
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		


func _on_exit_pressed():
	get_tree().quit()


func _on_character_shop_pressed():
	get_tree().change_scene_to_file(shop)


func _on_level_pressed():
	get_tree().change_scene_to_file(level)
	

func _on_main_menu_pressed():
	get_tree().change_scene_to_file(main_menu)
