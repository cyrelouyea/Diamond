extends Node2D

var value = 0

func _process(delta):
	delta *= Global.speed
	scale = lerp(scale, Vector2(1, 1), delta * 5)

func set_score(score: int):
	value = score
	$HiScoreValue.text = (str(value))
	scale = Vector2(1.5, 1.5)

func reset():
	value = 0
	$HiScoreValue.text = str(value)
	scale = Vector2(0.8, 0.8)
