extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	SignalManager.on_show_exit.connect(on_show_exit)


func on_show_exit() -> void:
	set_deferred("monitoring", true)
	show()


func _on_body_entered(body):
	SignalManager.on_exit.emit()
