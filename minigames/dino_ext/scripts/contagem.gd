extends Node

var tempo = 3

func _ready():
	pass
	
func _on_timer_timeout():
	tempo -= 1
	$label.text = str(tempo)
	if tempo <= 0:
		get_tree().paused = false
		print("passou")
		queue_free()
