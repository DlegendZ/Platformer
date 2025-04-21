extends Area2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D
var left = true
var alive = true
@onready var timer = randf_range(3.0,5.0)
func _process(delta):
	if alive == true :
		if left == true :
			animated_sprite_2d.flip_h = false
			global_position.x -= 40 * delta
			await get_tree().create_timer(timer).timeout
			left = false
		elif left == false :
			animated_sprite_2d.flip_h = true
			global_position.x += 40 * delta
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


