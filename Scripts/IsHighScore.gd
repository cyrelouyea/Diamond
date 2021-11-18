extends Label


var c_delta = 0

func _process(delta):
	modulate.a = 0.75 + 0.25 * cos(c_delta * 10)
	c_delta += delta
