extends CharacterBody2D


class_name Player


const SPEED: float = 200


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input()
	move_and_slide()
	rotation = velocity.angle()


func get_input() -> void:
	var mv = Vector2.ZERO
	mv.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	mv.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = mv.normalized() * SPEED
