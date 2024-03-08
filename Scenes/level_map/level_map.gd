extends Node2D


@onready var pickups = $Pickups


var _pickups_count: int = 0
var _collected: int = 0 

# Called when the node enters the scene tree for the first time.
func _ready():
	_pickups_count = pickups.get_children().size()
	SignalManager.on_pickup.connect(on_pickup)
	SignalManager.on_exit.connect(on_exit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func on_exit() -> void:
	print("GAME OVER")


func check_show_exit() -> void:
	if _collected == _pickups_count:
		SignalManager.on_show_exit.emit()
		print("on_show_exit")


func on_pickup() -> void:
	print("on_pickup")
	_collected += 1
	check_show_exit()
