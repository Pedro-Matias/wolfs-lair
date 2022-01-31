extends Node


func ready(delta):
	pass


func damage():
	get_node("anim").play("Died")
