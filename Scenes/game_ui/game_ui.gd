extends Control

@onready var score_label = $MC/ScoreLabel
@onready var exit_label = $MC/ExitLabel
@onready var time_label = $MC/TimeLabel
@onready var color_rect = $ColorRect
@onready var game_over_label = $ColorRect/GameOverLabel
@onready var animation_player = $AnimationPlayer


var _time: float = 0.0
var _game_over: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	score_label.show()
	SignalManager.on_show_exit.connect(on_show_exit)
	SignalManager.on_exit.connect(on_exit)
	SignalManager.on_game_over.connect(on_game_over)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _game_over == false:	
		_time += delta
		time_label.text = "%.1f seconds" % _time
	elif Input.is_action_just_pressed("press_space"):
		GameManager.load_main_scene()


func update_score(actual: int, target: int) -> void:
	score_label.text = "%s / %s" % [actual, target]


func on_game_over() -> void:
	if _game_over == false:
		color_rect.show()
		_game_over = true
		game_over_label.text = "MISSION FAILED!\nPRESS SPACE"


func on_show_exit() -> void:
	exit_label.show()
	animation_player.play("escape")


func on_exit() -> void:
	_game_over = true
	animation_player.stop(true)
	color_rect.show()
	game_over_label.text = "Mission Complete! \n You took %.1f seconds\nPress Space" % _time
