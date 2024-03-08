extends Node2D


@onready var pickups = $Pickups
@onready var game_ui = $CanvasLayer/GameUI


var _pickups_count: int = 0
var _collected: int = 0 

# Called when the node enters the scene tree for the first time.
func _ready():
	_pickups_count = pickups.get_children().size()
	game_ui.update_score(_collected, _pickups_count)
	SignalManager.on_pickup.connect(on_pickup)
	SignalManager.on_exit.connect(on_exit)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func on_exit() -> void:
	for n in get_tree().get_nodes_in_group("bullet"):
		n.queue_free()
	
	var p = get_tree().get_first_node_in_group("player")
	p.set_physics_process(false)
	
	for n in get_tree().get_nodes_in_group("npc"):
		n.stop_action()
		
	print("GAME OVER")


func check_show_exit() -> void:
	if _collected == _pickups_count:
		SignalManager.on_show_exit.emit()
		print("on_show_exit")


func on_pickup() -> void:
	print("on_pickup")
	_collected += 1
	game_ui.update_score(_collected, _pickups_count)
	check_show_exit()
