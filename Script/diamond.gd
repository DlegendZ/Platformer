extends Area2D
@onready var oneshot = true
@onready var gravityS = false
@onready var animation_player = $AnimationPlayer
@onready var flying = true
@onready var ground = false

func _process(delta):
	if gravityS == true :
		global_position.y += 50 * delta
	
func animation_player_play() :
	if oneshot == true :
		animation_player.play("Drop_diamond")
		oneshot = false
		gravityS = true
		flying = false

func _on_body_entered(body):
	if body.name == "Blocks" :
		gravityS = false #to stop going down when reaching the ground.
		ground = true
	if body.name == "Player" :
		body.get_diamond()
		queue_free()
