extends Control
@onready var lobby = $Lobby
@onready var battle = $Battle
@onready var place 

func _process(_delta):
	if place == "Lobby" :
		battle.stop()
		if lobby.playing == false :
			lobby.play()
	elif place == "World" :
		lobby.stop()
		if battle.playing == false :
			battle.play()

