extends Area2D

signal score

func _on_Bin_Area_body_entered(body):
	emit_signal("score")
	body.queue_free()
