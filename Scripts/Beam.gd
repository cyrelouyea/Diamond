extends Node2D

export var size: float

var r_scale = 1
var s_scale = 0
var d_scale = 0
var dst_scale = 0
var activated = false

func _process(delta):
	delta *= Global.speed
	$Beam1.scale.y = s_scale * (r_scale + 0.1 * cos(d_scale * 20))
	$Beam2.scale.y = s_scale * (r_scale + 0.1 * cos(d_scale * 4))
	$Beam1.region_rect.size.x = size
	$Beam2.region_rect.size.x = size
	s_scale = lerp(s_scale, dst_scale, delta * 20)
	d_scale += delta

func activate(b: bool):
	activated = b
	if b:
		$ActivateSE.play()
		dst_scale = 1
	else:
		dst_scale = 0
		
func set_color(c: int):
	$Beam1.material.set_shader_param("alpha", c)
