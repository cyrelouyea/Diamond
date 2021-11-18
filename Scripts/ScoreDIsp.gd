extends Label

onready var offset = rect_position.y - 64
var t = 0

func _process(delta):
	rect_position.y = lerp(rect_position.y, offset, delta * 5)
	if t > 1:
		queue_free()
	t += delta
