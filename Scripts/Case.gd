extends Sprite

var d_scale = Vector2(1, 1)
var c_delta = 0

func _process(delta):
	delta *= Global.speed
	if c_delta > 0.98:
		d_scale = Vector2(1.3, 1.3)
		c_delta = 0
	d_scale = lerp(d_scale, Vector2(1, 1), delta * 6)
	scale = d_scale
	c_delta += delta


func hover(b: bool):
	if b:
		modulate.a = 1.0
	else:
		modulate.a = 0.3
