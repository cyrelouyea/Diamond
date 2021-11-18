extends Node2D


var c_delta = 0

func _process(delta):
	modulate.a = 0.8 + 0.2 * cos(c_delta * 5)
	c_delta += delta
