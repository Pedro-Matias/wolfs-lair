extends Control

#onready var button_sfx = get_node("Button-Press")

func _ready():
	#button_sfx.play()
	pass

# comeca o jogo (sem save state no momento)
func _on_Play_pressed():
	#button_sfx.play()
	get_tree().change_scene(("res://minigames/dino_ext/scenes/Node.tscn"))

# fecha o game
func _on_Exit_pressed():
	get_tree().quit()
