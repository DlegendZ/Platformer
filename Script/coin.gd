extends Area2D
@onready var animation_player = $AnimationPlayer
@onready var oneshot = true
@onready var ground = false
@onready var gravityS = false
@onready var Dropcoin = false
@onready var ready_to_be_taken = false

func _ready():
	pass

func _process(delta):
	if gravityS == true :
		global_position.y += 50 * delta

func animation_player_play() :
	if oneshot == true :
		animation_player.play("Drop_coin")
		oneshot = false
		gravityS = true
		await get_tree().create_timer(0.5).timeout
		ready_to_be_taken = true

func _on_body_entered(body):
	if body.name == "Blocks" :
		gravityS = false #to stop falling when reaching the ground.
		ground = true
	if body.name == "Player" and Dropcoin == true and ready_to_be_taken == true:
		body.get_coins()
		queue_free()
	if body.name == "Player" and Dropcoin == false:
		body.get_coins()
		queue_free()



