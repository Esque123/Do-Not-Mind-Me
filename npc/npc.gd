extends CharacterBody2D


const SPEED: float = 160.0


@export var patrol_points: NodePath


@onready var sprite_2d = $Sprite2D
@onready var nav_agent = $NavAgent
@onready var label = $Label
@onready var player_detect = $PlayerDetect
@onready var ray_cast_2d = $PlayerDetect/RayCast2D


var _waypoints: Array = []
var _current_wp: int = 0
var _player_ref: Player


# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	create_wp()
	_player_ref = get_tree().get_first_node_in_group("player")
	call_deferred("set_physics_process", true)


func create_wp() -> void:
	for child in get_node(patrol_points).get_children():
		_waypoints.append(child.global_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_pressed("set_target"):
		nav_agent.target_position = get_global_mouse_position()
	raycast_to_player()
	update_navigation()
	process_patrolling()
	set_label()


func raycast_to_player() -> void:
	player_detect.look_at(_player_ref.global_position)


func player_detected() -> bool:
	var c = ray_cast_2d.get_collider()
	if c != null:
		return c.is_in_group("player")
	return false


func update_navigation() -> void:
	if nav_agent.is_navigation_finished() == false:
		var next_path_position: Vector2 = nav_agent.get_next_path_position()
		sprite_2d.look_at(next_path_position)
		velocity = global_position.direction_to(next_path_position) * SPEED
		move_and_slide()


func navigate_wp() -> void:
	if _current_wp >= len(_waypoints):
		_current_wp = 0
	nav_agent.target_position = _waypoints[_current_wp]
	_current_wp += 1


func process_patrolling() -> void:
	if nav_agent.is_navigation_finished() == true:
		navigate_wp()


func set_label() -> void:
	var s = "Done: %s\n" % nav_agent.is_navigation_finished()
	s += "Reached?: %s\n" % nav_agent.is_target_reached()
	s += "Target: %s\n" % nav_agent.target_position
	s += "PlayerDetected: %s\n" % player_detected()
	label.text = s
	
