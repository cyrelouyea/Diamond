extends Node2D

signal zero_health

var value = 100

func _process(delta):
	$Bar.region_rect.size.x = lerp($Bar.region_rect.size.x, 760.0 * value / 100.0,  delta * 5)

func take_hit(v: int):
	set_value(value - v)
	
func add_health(v: int):
	set_value(value + v)
	
func set_value(v: int):
	value = max(min(v, 100), 0)
	if value == 0:
		emit_signal("zero_health")

func reset():
	set_value(100)
