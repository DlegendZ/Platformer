extends CharacterBody2D
signal playerdiamond
signal playerdie
signal playercoin
@onready var alive = true
@export var speed = 10000
@onready var animated_sprite_2d = $AnimatedSprite2D
@export var gravity = 980
@export var jump = 20000
@onready var Spawn_Coor
@onready var active = true
@export var jump_force = 25000
@onready var collision_shape_2d = $PlayerFeet/CollisionShape2D
@onready var touched = false
@onready var gpu_particles_2d = $GPUParticles2D
@onready var animation_player = $AnimationPlayer
@onready var pos
@export var knockback_force = 25000
@export var weakness_force = 20000
@onready var world_name
@onready var camera_2d = $Camera2D
@onready var knockback_audio = $Knockback
@onready var coin_diamond = $"coin diamond"
@onready var jumping_audio = $Jumping
@onready var explosion = $Explosion
@onready var default = preload("res://SpriteFrames/default.tres")
@onready var blue = preload("res://SpriteFrames/Blue Ocean.tres")
@onready var yellow = preload("res://SpriteFrames/YellowPoo.tres") 
func _ready() :
	read_skin_data()
	if Gvar.character == "default" :
		animated_sprite_2d.sprite_frames = default
	elif Gvar.character == "blue" :
		animated_sprite_2d.sprite_frames = blue
	elif Gvar.character == "yellow" :
		animated_sprite_2d.sprite_frames = yellow
	else :
		animated_sprite_2d.sprite_frames = default
	
func read_skin_data() :
	var opendirskin = FileAccess.open("user://JourneySkin", FileAccess.READ)
	if opendirskin != null :
		Gvar.character = opendirskin.get_as_text()
		#print(Gvar.character)
	else :
		Gvar.character = "default"
		#print("default")

func _physics_process(delta):
	if !is_on_floor() :
		velocity.y += gravity * delta
	if alive == true :
		if is_on_floor() :
			if Input.is_action_pressed("Jump") :
				jumping_audio.play()
				velocity.y = -jump * delta
		if touched == false :
			if !is_on_floor() or is_on_floor() :
				if Input.is_action_pressed("Left") :
					velocity.x = -speed * delta
					animated_sprite_2d.play("Walking")
					animated_sprite_2d.flip_h = false
				elif Input.is_action_pressed("Right") :
					velocity.x = speed * delta
					animated_sprite_2d.play("Walking")
					animated_sprite_2d.flip_h = true
				else :
					velocity.x = 0
					animated_sprite_2d.play("Idle")
		elif touched == true :
			if pos == "behind" :
				velocity.x = -knockback_force * delta
			elif pos == "front" :
				velocity.x = knockback_force * delta
			elif pos == "under" :
				velocity.y = -jump_force * delta
			elif pos == "top" :
				velocity.y = jump_force * delta
			elif pos == "weakness" :
				velocity.y = -weakness_force * delta
			elif pos == "behind_and_above" :
				velocity = Vector2(-knockback_force,-10000) * delta
			elif pos == "behind_and_under" :
				velocity = Vector2(-knockback_force,10000) * delta
			elif pos == "front_and_above" :
				velocity = Vector2(knockback_force,-10000) * delta
			elif pos == "front_and_under" :
				velocity = Vector2(knockback_force,10000) * delta
		
	move_and_slide()
	
func ready_start_pos(id) :
	global_position = id
	Spawn_Coor = id
	
func knockback() :
	if touched == false and alive == true :
		touched = true
		modulate = Color(0.416, 0.416, 0.416 ,1)
		animated_sprite_2d.play("Walking")
		await get_tree().create_timer(0.1).timeout
		modulate = Color(1,1,1,1)
		touched = false
		animated_sprite_2d.play("Idle")
		knockback_audio.play()
	if active == true :
		emit_signal("playerdie")
		active = false
		await get_tree().create_timer(1.0).timeout
		active = true
	elif active == false :
		pass
	
func jumping() :
	if touched == false :
		touched = true
		animated_sprite_2d.play("Walking")
		await get_tree().create_timer(0.1).timeout
		touched = false
		animated_sprite_2d.play("Idle")
	
func explode() :
	alive = false
	velocity.x = 0 
	animation_player.play("Explosion_Preparation")
	await get_tree().create_timer(0.5).timeout
	explosion.play()
	animated_sprite_2d.visible = false
	gpu_particles_2d.emitting = true

func _on_gpu_particles_2d_finished():
	get_tree().reload_current_scene()
	
func get_coins() :
	coin_diamond.play()
	emit_signal("playercoin")
	
func get_diamond() :
	coin_diamond.play()
	emit_signal("playerdiamond")
