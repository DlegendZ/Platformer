extends StaticBody2D
@onready var diamond = $Diamond
@onready var oneshot = true





func _on_area_2d_body_entered(body):
	if body.name == "Player" and oneshot == true :
		oneshot = false
		diamond.visible = true
		diamond.animation_player_play()
