extends Area2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var collision_shape_2d_weakness = $Weakness/CollisionShape2D
var left = true
var alive = true
@onready var coin = $Coin
@onready var timer = randf_range(3.0,5.0) #7 blocks
@onready var weakness_audio = $Weakness_audio

func _ready():
	coin.Dropcoin = true
func _process(delta):
	if alive == true :
		if left == true :
			animated_sprite_2d.flip_h = false
			global_position.x -= 20 * delta
			await get_tree().create_timer(timer).timeout
			left = false
		elif left == false :
			animated_sprite_2d.flip_h = true
			global_position.x += 20 * delta
			await get_tree().create_timer(timer).timeout
			left = true
	


func _on_body_entered(body):
	if alive == true :
		if body.name == "Player" :
			if body.global_position.x < global_position.x :
				body.pos = "behind"
				body.knockback()
			elif body.global_position.x > global_position.x :
				body.pos = "front"
				body.knockback()



func _on_weakness_area_entered(area):
	if area.name == "PlayerFeet" and alive == true:
		var player = area.get_parent()
		animated_sprite_2d.play("Dead")
		weakness_audio.play()
		player.pos = "weakness"
		player.jumping()
		coin.visible = true
		coin.animation_player_play()
		alive = false

