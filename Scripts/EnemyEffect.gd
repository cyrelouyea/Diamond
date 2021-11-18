extends Node2D

export var color: int

var points = [
	Vector2(-7, 0),
	Vector2(-23,-21),
	Vector2(7, -21),
	Vector2(23, 0),
	Vector2(7, 21),
	Vector2(-23, 21),
	Vector2(-7, 0)
]


var t = 0
var speed = 0.8


func _process(delta):
	delta *= Global.speed
	if t > 1/speed:
		queue_free()
	t += delta
	update()

func _draw():
	draw_polyline(
		PoolVector2Array(points),
		Color(color * 1.0 + (1.0 - color) * 0.1, 0.1, color * 0.1 + (1.0 - color) * 1.0, 1.0 - t*speed),
		2,
		true
	)
