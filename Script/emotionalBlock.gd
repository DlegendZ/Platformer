extends StaticBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D
var  collision 

func _ready():
	collision = true
	animated_sprite_2d.play("Stable")
	


func _on_timer_timeout():
	if collision == true :
		animated_sprite_2d.play("Stable")
		collision_shape_2d.disabled = false
		animated_sprite_2d.self_modulate = Color(1,1,1,1)
		collision = false
	elif collision == false :
		animated_sprite_2d.play("Angry")
		collision_shape_2d.disabled = true
		animated_sprite_2d.self_modulate = Color(1,1,1,0.45)
		collision = true
