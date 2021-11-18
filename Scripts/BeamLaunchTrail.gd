extends Node2D

export var angle: float
export var size: float
export var offset: float
export var color: int

var alpha = 1.0
var t = 0

func _ready():
	rotation_degrees = angle
	position.x -= offset * cos(rotation + PI/2)
	position.y -= offset * sin(rotation + PI/2)
	t += offset

func _process(delta):
	delta *= Global.speed
	
	if t > 1:
		queue_free()
	t += delta
	update()

func _draw():
	draw_line(
		Vector2(-size/2, 0),
		Vector2(size/2, 0),
		Color(color * 1.0 + (1.0 - color) * 0.1, 0.1, color * 0.1 + (1.0 - color) * 1.0, 0.5*(alpha - t)),
		3 - t*3
	)
