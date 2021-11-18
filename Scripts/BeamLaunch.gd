extends Node2D

signal beam_lost
signal enemy_deleted
signal enemy_wrong


export var size: float
export var angle: float
export var speed = 850.0
export var launch_trail_sc: PackedScene
var color: int

var d_scale = 0.0
var d_fire = 0.0
var e_speed = speed * 0.2
var dst_scale = 1
var to_delete = false
var timer_delete = 1

func _ready():
	$Beam.region_rect.size.x = size
	$Beam2.region_rect.size.x = size
	$BallL1.position.x = -size/2
	$BallR1.position.x = size/2
	$BallL2.position.x = -size/2
	$BallR2.position.x = size/2
	$Collision.shape.extents.x = size/4
	rotation_degrees = angle
	
	connect("enemy_deleted", get_node("/root/Main"), "on_enemy_deleted")
	connect("beam_lost", get_node("/root/Main"), "on_beam_lost")
	connect("enemy_wrong", get_node("/root/Main"), "on_enemy_wrong")
	
	
	$Beam.material.set_shader_param("alpha", color)
	$BallL1.material.set_shader_param("alpha", color)
	$BallR1.material.set_shader_param("alpha", color)
	

func _process(delta):
	delta *= Global.speed
	
	if to_delete:
		scale = lerp(scale, Vector2(1, 1) * dst_scale, delta*15/Global.speed)
		timer_delete -= delta
		if timer_delete < 0:
			queue_free()
		return 
			
	if (global_position.x < -64 or global_position.x > get_viewport_rect().size.x + 64 
	or global_position.y < -64 or global_position.y > get_viewport_rect().size.y + 64):
		emit_signal("beam_lost")
		queue_free()
		
	$Beam.scale.y = (0.5 + 0.1 * cos(d_scale * 20))
	$Beam2.scale.y = (0.5 + 0.1 * cos(d_scale * 4))
	$BallL1.scale = Vector2(1, 1) * (1 + 0.1 * cos(d_scale * 20))
	$BallR1.scale = Vector2(1, 1) * (1 + 0.1 * cos(d_scale * 20))
	$BallL2.scale = Vector2(1, 1) * (1 + 0.1 * cos(d_scale * 4))
	$BallR2.scale = Vector2(1, 1) * (1 + 0.1 * cos(d_scale * 4))
	
	position.x += delta * speed * cos(rotation + PI/2)
	position.y += delta * speed * sin(rotation + PI/2)
	speed = lerp(speed, e_speed, 7*delta)
	
	while d_fire > 10*delta/(Global.speed):
		var lt_ins = launch_trail_sc.instance()
		lt_ins.size = size
		lt_ins.angle = angle
		lt_ins.position = global_position
		lt_ins.offset = d_fire - 10*delta/(Global.speed*2)
		lt_ins.color = color
		get_node("/root").add_child(lt_ins)
		d_fire -= 10*delta/(Global.speed)
	
	d_scale += delta
	d_fire += delta
	

func _on_BeamLaunch_area_entered(area: Area2D):
	delete()
	if area.color == color:
		$ggSE.play()
		area.delete(get_node("/root/Main/").score_combo_value())
		emit_signal("enemy_deleted")
	else:
		area.delete(0)
		emit_signal("enemy_wrong")
	
func delete():
	$Collision.call_deferred("disabled", true)
	disconnect("area_entered", self, "_on_BeamLaunch_area_entered")
	to_delete = true
	dst_scale = 0

