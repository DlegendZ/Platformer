extends Control
@onready var default = preload("res://SpriteFrames/default.tres")
@onready var blue = preload("res://SpriteFrames/Blue Ocean.tres")
@onready var yellow = preload("res://SpriteFrames/YellowPoo.tres")
@onready var parallax_background = $CanvasLayer/ParallaxBackground
@onready var animated_sprite_2d_1 = $UI/Shopping_stuffs/First/AnimatedSprite2D
@onready var animated_sprite_2d_2 = $UI/Shopping_stuffs/Second/AnimatedSprite2D2
@onready var animated_sprite_2d_3= $UI/Shopping_stuffs/Third/AnimatedSprite2D
@onready var label_diamond = $UI/Node_Diamond/Label
@onready var label_coin = $"UI/Node _ Coins/Label"
@onready var C2bought : String
@onready var C3bought : String
@onready var price_2 = $UI/Shopping_stuffs/Second/Price
@onready var price_3 = $UI/Shopping_stuffs/Third/Price
@onready var price_tag_2 = $"UI/Shopping_stuffs/Second/Price Tag"
@onready var price_tag_3 = $"UI/Shopping_stuffs/Third/Price Tag"

func _ready():
	read_data()
	animated_sprite_2d_1.sprite_frames = default
	animated_sprite_2d_2.sprite_frames = blue
	animated_sprite_2d_3.sprite_frames = yellow
	label_diamond.text = "x " + str(Gvar.globaldiamond)
	label_coin.text = "x " + str(Gvar.globalcoin)
	if C2bought == "notowned" :
		price_tag_2.text = "buy"
		price_2.visible = true
	elif C2bought == "owned" :
		price_2.visible = false
		price_tag_2.text = "owned"
	
	if C3bought == "notowned" :
		price_tag_3.text = "buy"
		price_3.visible = true
	elif C3bought == "owned" :
		price_3.visible = false
		price_tag_3.text = "owned"
	
func _process(delta): 
	parallax_background.scroll_base_offset -= Vector2(20 * delta, 20 * delta)

func read_data() :
	var opendirfalse_3 = FileAccess.open("user://JourneyFalse_3", FileAccess.READ)
	var opendirfalse_2 = FileAccess.open("user://JourneyFalse_2", FileAccess.READ)
	if opendirfalse_2 != null :
		C2bought = opendirfalse_2.get_as_text()
	else  :
		C2bought = "notowned"
	
	if opendirfalse_3 != null :
		C3bought = opendirfalse_3.get_as_text()
	else :
		C3bought = "notowned"
		
func save_data() :
	var opendirfalse_3 = FileAccess.open("user://JourneyFalse_3", FileAccess.WRITE)
	var opendirfalse_2 = FileAccess.open("user://JourneyFalse_2", FileAccess.WRITE)
	var opendirdiamond = FileAccess.open("user://JourneyDiamond", FileAccess.WRITE)
	var opendircoin = FileAccess.open("user://JourneyCoin", FileAccess.WRITE)
	opendirfalse_3.store_string(C3bought)
	opendirfalse_2.store_string(C2bought)
	opendircoin.store_32(Gvar.globalcoin)
	opendirdiamond.store_32(Gvar.globaldiamond)

func save_skin_data() :
	var opendirskin = FileAccess.open("user://JourneySkin", FileAccess.WRITE)
	opendirskin.store_string(Gvar.character)

func _on_button_1_pressed():
	Gvar.character = "default"
	save_data()
	save_skin_data()
	get_tree().change_scene_to_file(Gvar.level)
	
	

func _on_button_2_pressed():
	if C2bought == "notowned" :
		if Gvar.globalcoin >= 500 and Gvar.globaldiamond >= 100 :
			Gvar.globalcoin -= 500
			Gvar.globaldiamond -= 100
			Gvar.character = "blue"
			C2bought = "owned"
			save_data()
			save_skin_data()
			get_tree().change_scene_to_file(Gvar.level)
	elif C2bought == "owned" :
		Gvar.character = "blue"
		save_skin_data()
		get_tree().change_scene_to_file(Gvar.level)
		

func _on_button_3_pressed():
	if C3bought == "notowned" :
		if Gvar.globalcoin >= 500 and Gvar.globaldiamond >= 100 :
			Gvar.globalcoin -= 500
			Gvar.globaldiamond -= 100
			Gvar.character = "yellow"
			C3bought = "owned"
			save_data()
			save_skin_data()
			get_tree().change_scene_to_file(Gvar.level)
	elif C3bought == "owned" :
		Gvar.character = "yellow"
		save_skin_data()
		get_tree().change_scene_to_file(Gvar.level)
	
