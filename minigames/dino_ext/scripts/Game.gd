extends Node

var tiro = true

#onready var button_sfx = get_node("Button-Press")

export (PackedScene) var Meteor

var tempo = 3


func _ready():
	OS.window_size = Vector2(640, 720)
	configuration.last_game(2)

	get_tree().paused = true

func _input(event):
	if event.is_action_pressed("click") and tiro:
		var new_ball = Meteor.instance()
		new_ball.position = Vector2 (get_viewport().get_mouse_position().x,20)
		print("clickando")
		tiro = false
		get_node("coldown_tiro").start()
		add_child(new_ball)
	elif event.is_action_pressed("ESC"):
		#button_sfx.play()
		get_tree().change_scene("res://scenes/Main-Menu.tscn")

func _on_coldown_tiro_timeout():
	tiro = true
