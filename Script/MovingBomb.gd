extends Area2D
@onready var up = true
@onready var moving = true
@onready var animation_player = $AnimationPlayer
@onready var gpu_particles_2d = $GPUParticles2D
@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var touched = true
@onready var speed
@onready var delta_value
@onready var timer = randf_range(5.0,7.0)
@onready var explosion = $Explosion

func _process(delta):
	if moving == true :
		if up == true :
			global_position.y -= 50 * delta
			await get_tree().create_timer(timer).timeout
			up = false
		elif up == false :
			global_position.y += 50 * delta
			await get_tree().create_timer(timer).timeout
			up = true

func _on_body_entered(body):
	if touched == true :
		if body.name == "Player" :
			moving = false
			touched = false
			animation_player.play("Explosion_preparation")
			await get_tree().create_timer(2.5).timeout
			explosion.play()
			sprite_2d.visible = false
			gpu_particles_2d.emitting = true			#safezone if they are still in the area.
	elif touched == false : 		#when they are not in the safe area, give some dmg in a certain area.
		if body.name == "Player" :
			if body.global_position.x < global_position.x :
				if body.global_position.y < global_position.y :
					body.pos = "behind_and_above"
					body.knockback()
				elif body.global_position.y > global_position.y :
					body.pos = "behind_and_under"
					body.knockback()
			elif body.global_position.x > global_position.x :
				if body.global_position.y < global_position.y :
					body.pos = "front_and_above"
					body.knockback()
				elif body.global_position.y > global_position.y :
					body.pos = "front_and_under"
					body.knockback()

func _on_gpu_particles_2d_finished() :
	queue_free()
