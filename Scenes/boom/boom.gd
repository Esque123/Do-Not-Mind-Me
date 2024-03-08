extends AnimatedSprite2D


@onready var audio_stream_player_2d = $AudioStreamPlayer2D


func _on_audio_stream_player_2d_finished():
	queue_free()
