extends Node2D

var d_scale = 0
var activated = false

func _process(delta):
	delta *= Global.speed
	$BallOut.scale = Vector2(1, 1) * (0.9 + 0.05 * cos(d_scale * 20))
	$BallIn.scale = Vector2(1, 1) * (0.5 + 0.1 * sin(d_scale * 4))
	d_scale += delta

func hover(b: bool):
	$Case.hover(b)

func activate(b: bool):
	activated = b
	if b:
		$BallOut.show()
		$BallIn.show()
	else:
		$BallOut.hide()
		$BallIn.hide()
		
func toggle():
	activate(!activated)
	
func set_color(c: int):
	$Case.material.set_shader_param("alpha", c)
	$BallOut.material.set_shader_param("alpha", c)
