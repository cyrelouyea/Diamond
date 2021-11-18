extends Node2D

export var dist: float
export var color: int

var t = 0
var nb_lines = 25
var step = 2*PI/nb_lines

func _process(delta):
	delta *= Global.speed
	t += delta * 0.1
	update()

func _draw():
	for i in range(nb_lines):
		var av = t + i * step
		draw_line(
			Vector2(-dist/2 + dist/2 * cos(av), 1),
			Vector2(0, -dist/2 + dist/2 * cos(av)),
			Color(color * 1.0 + (1.0 - color) * 0.1, 0.1, color * 0.1 + (1.0 - color) * 1.0, 0.5),
			1
		)
		
		draw_line(
			Vector2(dist/2 - dist/2 * cos(av), -1),
			Vector2(0, dist/2 - dist/2 * cos(av)),
			Color(color * 1.0 + (1.0 - color) * 0.1, 0.1, color * 0.1 + (1.0 - color) * 1.0, 0.5),
			1
		)
		
		draw_line(
			Vector2(-dist/2 + dist/2 * cos(av), 0),
			Vector2(0, dist/2 - dist/2 * cos(av)),
			Color(color * 1.0 + (1.0 - color) * 0.1, 0.1, color * 0.1 + (1.0 - color) * 1.0, 0.5),
			1
		)
		
		draw_line(
			Vector2(dist/2 - dist/2 * cos(av), 0),
			Vector2(0, -dist/2 + dist/2 * cos(av)),
			Color(color * 1.0 + (1.0 - color) * 0.1, 0.1, color * 0.1 + (1.0 - color) * 1.0, 0.5),
			1
		)
