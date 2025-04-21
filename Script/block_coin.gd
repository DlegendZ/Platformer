extends StaticBody2D
@onready var coin = $Coin
@onready var oneshot = true

func _on_area_2d_body_entered(body):
	if body.name == "Player" and oneshot == true:
		oneshot = false
		coin.visible = true
		coin.animation_player_play()
