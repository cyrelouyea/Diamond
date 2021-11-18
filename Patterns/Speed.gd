extends Node2D

var value = 0

func _process(delta):
	delta *= Global.speed
	scale = lerp(scale, Vector2(1, 1), delta * 5)

func set_speed(speed: float):
	value = speed
	$SpeedValue.text = "x %.1f" % value 
	scale = Vector2(1.5, 1.5)

	
