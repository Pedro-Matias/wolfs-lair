extends RigidBody2D

var select

# botao de reset estilo iphone antigo
func _input(event):
	if Input.is_action_pressed("click"):
		select = true
	if event.is_action_released("click"):
		select = false

func _physics_process(delta):
	if select:
		global_position.x = lerp(global_position.x, get_global_mouse_position().x, 25 * delta)
