extends Area2D

export var direction: String
export var dist =  700
export var speed = 100
export var en_eff_sc: PackedScene
export var color: int
export var score_sc: PackedScene

var dir_to_pos = {
	"T": Vector2(0, -1),
	"B": Vector2(0, 1),
	"L": Vector2(-1, 0),
	"R": Vector2(1, 0),
	"TR": Vector2(1, -1),
	"TL": Vector2(-1, -1),
	"BR": Vector2(1, 1),
	"BL": Vector2(-1, 1),
}

var dir_to_angle = {
	"T": 90,
	"B": -90,
	"L": 0,
	"R": 180,
	"TR": 135,
	"TL": 45,
	"BR": -135,
	"BL": -45,
}

var d_scale = 0
var d_fire = 0
var to_delete = false
var dst_scale = 1
var timer_delete = 1

func _ready():
	position = dir_to_pos[direction].normalized() * dist
	$Sprite.rotation_degrees = dir_to_angle[direction]
	$Sprite.material.set_shader_param("alpha", color)
	$Particles2D.material.set_shader_param("alpha", color)

	
func _process(delta):
	delta *= Global.speed
	
	if to_delete:
		scale = lerp(scale, Vector2(1, 1) * dst_scale, delta*15/Global.speed)
		timer_delete -= delta
		if timer_delete < 0:
			queue_free()
		return 
		
	position.x += delta * speed * cos($Sprite.rotation)
	position.y += delta * speed * sin($Sprite.rotation)
	
	while d_fire > 50*delta/Global.speed:
		var en_ins = en_eff_sc.instance()
		en_ins.position = global_position
		en_ins.rotation_degrees = $Sprite.rotation_degrees
		en_ins.color = color
		get_node("/root").add_child(en_ins)
		d_fire -= 50*delta/(Global.speed)
	
	d_scale += delta
	d_fire += delta
	
func delete(score: int):
	$Collision.call_deferred("disabled", true)

	if score != 0:
		var score_ins = score_sc.instance()
		score_ins.rect_position = global_position - Vector2(48, 0)
		score_ins.text = "+" + str(score)
		score_ins.set("custom_colors/font_color", Color(color * 1.0 + (1.0 - color) * 0.1, 0.1, color * 0.1 + (1.0 - color) * 1.0))
		get_node("/root").add_child(score_ins)
		
	collision_layer = 0
	$Particles2D.show()
	$Particles2D.emitting = true
	to_delete = true
	dst_scale = 0
