extends Area2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D




func _on_body_entered(body):
	if body.name == "Player" :
		body.pos = "under"
		body.knockback()
