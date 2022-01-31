extends Node

var tempo = 10

func _ready():
	pass

func _on_Timer_timeout():
	tempo -= 1
	get_node("Label").text = str(tempo)
	if tempo <= 0:
		get_tree().change_scene("res://minigames/pw_crck/scenes/Phone.tscn")
