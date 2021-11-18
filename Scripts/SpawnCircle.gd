extends Node2D


export var color: int
export var speed = 100

var dist = 700
var nb_lines = 36
var step =  PI*2/nb_lines

func _process(delta):
	delta *= Global.speed
	dist -= speed * delta
	if dist < 0:
		queue_free()
	update()

func _draw():
	for i in range(nb_lines):
		draw_line(
			Vector2(dist * cos(i * step), dist * sin(i * step)),
			Vector2(dist * cos((i+1) * step), dist * sin((i+1) * step)),
			Color(color * 1.0 + (1.0 - color) * 0.1, 0.1, color * 0.1 + (1.0 - color) * 1.0, 1.0 - (700 - dist) / 700.0),
			1
		)

func delete(sc: int):
	pass
