extends Node

onready var muted_icon = preload("res://minigames/recycle/assets/icons/Mute-1.png")
onready var unmuted_icon = preload("res://minigames/recycle/assets/icons/Volume-1.png")

export(PackedScene) var File

var score = 0
signal won

func _input(event):
	if event.is_action_pressed("ESC"):
		get_tree().change_scene("res://scenes/Main-Menu.tscn")

func _ready():
	# popula label, botao e animacao
	OS.window_size = Vector2(640, 480)
	
	configuration.last_game(1)
	
	var os_time = OS.get_datetime(false)
	get_node("Sprite/Time").text = String(os_time.hour) +":" +String(os_time.minute)
	var anim_hint = get_node("Hint/Hint-Animation")
	anim_hint.interpolate_property($Hint, "position:x", 800, -750, 10, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	anim_hint.start()

	# cria 8 arquivos random
	for i in 8:
		_create_file()

func _process(delta):
	if Input.is_action_just_pressed("space"):
		_create_file()


func _create_file():
	var x_range = Vector2(30, get_viewport().size.x -60)
	var y_range = Vector2(30, get_viewport().size.y -60)

	var random_x = randi() % int(x_range[1]- x_range[0]) + 1 + x_range[0] 
	var random_y =  randi() % int(y_range[1]-y_range[0]) + 1 + y_range[0]

	var random_pos = Vector2(random_x, random_y)
	var file = File.instance()
	add_child(file)
	file.position = random_pos


func _on_Bin_Area_score():
	score += 1;
	
	if score >= 10:
		emit_signal("won")

	get_node("Score").text = String(score) +"/10"

func _on_Mute_pressed():
	var _icon = get_node("Sprite/Mute").icon
	
	if AudioServer.is_bus_mute(AudioServer.get_bus_index("Master")):
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
		_icon = unmuted_icon
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
		_icon = muted_icon


func _on_Main_won():
	var win_anim = get_node("You_Won/BSoS-Animation")
	win_anim.interpolate_property($You_Won, "position:y", 0, 480, 0.5, Tween.TRANS_SINE, Tween.EASE_OUT)
	win_anim.start()

# jogar novamente?
func _on_Play_Again_pressed():
	score = 0
	get_parent().get_children().clear()
	get_node("Score").text = String(score) +"/10"

	var win_anim = get_node("You_Won/BSoS-Animation")
	win_anim.interpolate_property($You_Won, "position:y", 480, 0, 0.5, Tween.TRANS_SINE, Tween.EASE_OUT)
	win_anim.start()
	
	get_tree().change_scene("res://minigames/dino_ext/scenes/Node.tscn")
