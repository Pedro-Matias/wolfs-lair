extends Node2D

export(PackedScene) var Butao

var rig = [false, false, false, false]
var num = [0, 0, 0, 0]
onready var Num:Array = [
	get_node("HBoxContainer/Num1"),
	get_node("HBoxContainer/Num2"),
	get_node("HBoxContainer/Num3"),
	get_node("HBoxContainer/Num4")
	]

onready var Time = get_node("Time")
onready var Progress = get_node("Progress")
var timer = 60

signal crack

var score
var num_crack = [0, 0, 0, 0]

# reseta o timer e limpa os botoes
func _ready():
	OS.window_size = Vector2(320, 480)
	configuration.last_game(3)

	get_node("Success").hide()
	randomize()
	_reset()
	score = 0
	get_node("Bloom/Score").text = String(score) +"/3"

# sempre que o tempo acabar, tire 1 de timer
func _on_Time_timeout():
	timer -= 1
	Progress.value = timer

	if timer <= 0:
		get_tree().change_scene("res://scenes/Main-Menu.tscn")

func _on_Num1_pressed():
	num[0] += 1
	if num[0] == 10:
		num[0] = 0
	Num[0].text = " "+ String(num[0]) +" "

func _on_Num2_pressed():
	num[1] += 1
	if num[1] == 10:
		num[1] = 0
	Num[1].text =" "+ String(num[1]) +" "

func _on_Num3_pressed():
	num[2] += 1
	if num[2] == 10:
		num[2] = 0
	Num[2].text =" "+ String(num[2]) +" "

func _on_Num4_pressed():
	num[3] += 1
	if num[3] == 10:
		num[3] = 0
	Num[3].text =" "+ String(num[3]) +" "


# reseta para jogar mais uma vez
func _reset():
	Num[0].text = " 0 "
	Num[1].text = " 0 "
	Num[2].text = " 0 "
	Num[3].text = " 0 "

	Num[0].disabled = false
	Num[1].disabled = false
	Num[2].disabled = false
	Num[3].disabled = false

	for i in 4:
		get_node("HBoxContainer/Num"+ String(i+1) +"/AnimationPlayer").play("RESET")

	num = [0, 0, 0, 0]
	rig = [false, false, false, false]

	for i in 4:
		num_crack[i] = randi() % 10

	var hacker_anim = get_node("HackerText/HackerAnim")
	hacker_anim.interpolate_property($HackerText, "position:y", 60, -4000, 60, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT) 
	hacker_anim.start()


# checa os numeros passados pelo jogador - nem tenta entender
func _on_Check_pressed():
	for i in 4:
		var temp = true
		if Num[i].text.to_int() == num_crack[i]: # acertou
			get_node("HBoxContainer/Num"+ String(i+1) +"/AnimationPlayer").play("Right")
			temp = false
			rig[i] = true
			Num[i].disabled = true
		for j in 4:
			if Num[i].text.to_int() == num_crack[j] and !rig[j]: # quase
				temp = false
				get_node("HBoxContainer/Num"+ String(i+1) +"/AnimationPlayer").play("Almost")
				break
		if temp:
			get_node("HBoxContainer/Num"+ String(i+1) +"/AnimationPlayer").play("Wrong")

	if rig[0] and rig[1] and rig[2] and rig[3]:
		get_node("Bloom/Crack").play("Crack")
		emit_signal("crack")


# quando os 4 numeros estiverem certos, reseta e soma um no score
func _on_Phone_crack():
	score += 1
	timer = 60
	_reset()

	get_node("Bloom/Score").text = String(score) +"/3"

	# com 3 invasoes, mostra o "success"
	if score == 3:
		get_node("Success").show()
		get_node("Check").hide()
		
		var butao = Butao.instance()
		add_child(butao)
		butao.position = Vector2(55, 370)

# sinal da colisao dos botoes
func _on_Area2D_body_entered(body):
	body.queue_free()
	get_node("Check").show()

	get_tree().change_scene("res://scenes/Main-Menu.tscn")

func _input(event):
	if event.is_action_pressed("ESC"):
		get_tree().change_scene("res://scenes/Main-Menu.tscn")
