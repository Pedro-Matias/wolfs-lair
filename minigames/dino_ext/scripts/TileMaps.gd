extends Node

signal dano

func ready(delta):
	pass


func _on_Area2D_body_entered(body):
	print("Contato_Area")
	body.damage()
	


func _on_Pack_body_entered(body):
	print("Sinal")
	body.damage()
	emit_signal("dano")
