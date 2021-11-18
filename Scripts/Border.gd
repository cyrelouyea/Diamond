extends Node2D

var color: int

var t = 0.0

func _process(delta):
	t += delta
	update()


func _draw():
	draw_line(
		Vector2(-480, -480),
		Vector2(-480, 480),
		Color(color * 1.0 + (1.0 - color) * 0.1, 0.1, color * 0.1 + (1.0 - color) * 1.0, 0.8 + 0.2 * cos(t*5)),
		5
	)
	
	draw_line(
		Vector2(-480, 480),
		Vector2(480, 480),
		Color(color * 1.0 + (1.0 - color) * 0.1, 0.1, color * 0.1 + (1.0 - color) * 1.0, 0.8 + 0.2 * cos(t*5)),
		5
	)
	
	draw_line(
		Vector2(480, 480),
		Vector2(480, -480),
		Color(color * 1.0 + (1.0 - color) * 0.1, 0.1, color * 0.1 + (1.0 - color) * 1.0, 0.8 + 0.2 * cos(t*5)),
		5
	)
	
	draw_line(
		Vector2(480, -480),
		Vector2(-480, -480),
		Color(color * 1.0 + (1.0 - color) * 0.1, 0.1, color * 0.1 + (1.0 - color) * 1.0, 0.8 + 0.2 * cos(t*5)),
		5
	)

