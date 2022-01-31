extends RigidBody2D

# randomizador de texturas 
var folder = preload("res://minigames/recycle/assets/icons/Folder-1.png")
var game = preload("res://minigames/recycle/assets/icons/Joy-1.png")
var prog = preload("res://minigames/recycle/assets/icons/Program-1.png")
var doc = preload("res://minigames/recycle/assets/icons/Web-Document-1.png")
var sprites:Array = [folder, game, prog, doc]

# randomizador de nome
var icon_name = [ 
	[ # Folder
		"_f-reports",
		"_f-sales",
		"_f-sues",
		"_f-work",
		"_f-homework",
		"Hentai"
	], [ # Games
		"AoE",
		"Bomberman",
		"Carmaggeddon",
		"Fallout",
		"Pinball3D",
		"Chess"
	], [ # Prog
		"MS Word 95",
		"MS Excel 95",
		"Notepad",
		"Calculator",
		"Paint",
		"Music Player"
	], [ # Docs
		"_d-contract",
		"_d-prices",
		"_d-calendar",
		"_d-contacts",
		"_d-fiscal",
		"_d-names"
	]
]

var select = false

func _ready():
	randomize()
	var file_type = randi() % sprites.size()

	get_node("Label").text = icon_name[file_type][randi() % icon_name[0].size()]
	get_node("Icon").texture = sprites[file_type]

# atualizacao fisica do programa
func _physics_process(delta):
	if select:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)

# quando clicado no RigidBody, setta o obj pra seguir o mouse
func _on_File_Body_input_event(viewport, event, shape_idx):
	if Input.is_action_pressed("click"):
		select = true

func _input(event):
	if event.is_action_released("click"):
		select = false
