extends Node2D

var t = 0
var nb_polygons = 3
var step = 2*PI/nb_polygons
var color = Color(1.0, 0.1, 0.1, 0.5)

func _process(delta):
	delta *= Global.speed
	t += delta 
	update()
	
func _draw():
	for i in range(nb_polygons):
		var av = t + i * step
		draw_polygon(
			PoolVector2Array([
				Vector2(-11 + 11 * cos(av), 0),
				Vector2(0, -11 + 11 * cos(av)),
				Vector2(11 - 11 * cos(av), 0),
				Vector2(0, 11 - 11 * cos(av)),
			]),
			PoolColorArray([
				color,
				color,
				color,
				color
			])
		)
