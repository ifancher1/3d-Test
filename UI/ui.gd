extends CanvasLayer

signal close
signal reset

func _on_quit_pressed():
	close.emit()


func _on_reset_pressed():
	reset.emit()
