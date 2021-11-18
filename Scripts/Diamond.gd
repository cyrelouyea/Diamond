extends Node2D

export var beam_launcher_sc: PackedScene

var real_pos = Vector2(-1, 0)
var offset = 80
var activated = false
var color

onready var vec_to_zone = {
	Vector2(-1, 0): $ZoneLeft,
	Vector2(1, 0): $ZoneRight,
	Vector2(0, -1): $ZoneTop,
	Vector2(0, 1): $ZoneBottom
}

onready var zone_to_vec = {
	$ZoneLeft: Vector2(-1, 0),
	$ZoneRight: Vector2(1, 0),
	$ZoneTop: Vector2(0, -1),
	$ZoneBottom: Vector2(0, 1)
}

onready var zones_to_beam = {
	$ZoneTop: {
		$ZoneBottom: $BeamV,
		$ZoneLeft: $BeamTL,
		$ZoneRight: $BeamTR
	},
	$ZoneBottom: {
		$ZoneTop: $BeamV,
		$ZoneLeft: $BeamBL,
		$ZoneRight: $BeamBR
	},
	$ZoneLeft: {
		$ZoneTop: $BeamTL,
		$ZoneBottom: $BeamBL,
		$ZoneRight: $BeamH
	},
	$ZoneRight: {
		$ZoneTop: $BeamTR,
		$ZoneBottom: $BeamBR,
		$ZoneLeft: $BeamH
	}
}

onready var beams = [
	$BeamBR, $BeamTR, $BeamTL, $BeamBL, $BeamH, $BeamV
]


var lines = []

func _ready():
	$ZoneTop.position = Vector2(0, -1) * offset
	$ZoneBottom.position = Vector2(0, 1) * offset
	$ZoneLeft.position = Vector2(-1, 0) * offset
	$ZoneRight.position = Vector2(1, 0) * offset
	$BeamBR.position = Vector2(0.5, 0.5) * offset
	$BeamTR.position = Vector2(0.5, -0.5) * offset
	$BeamTL.position = Vector2(-0.5, -0.5) * offset
	$BeamBL.position = Vector2(-0.5, 0.5) * offset
	$BeamBR.size = $ZoneBottom.position.distance_to($ZoneRight.position)
	$BeamTR.size = $ZoneTop.position.distance_to($ZoneRight.position)
	$BeamTL.size = $ZoneTop.position.distance_to($ZoneLeft.position)
	$BeamBL.size = $ZoneBottom.position.distance_to($ZoneLeft.position)
	$BeamH.size = offset * 2
	$BeamV.size = offset * 2
	$Effect.dist = offset
	
	$ZoneTop.hover(false)
	$ZoneBottom.hover(false)
	$ZoneLeft.hover(true)
	$ZoneRight.hover(false)
	
	$ZoneTop.activate(false)
	$ZoneBottom.activate(false)
	$ZoneLeft.activate(false)
	$ZoneRight.activate(false)
	
	$BeamBR.activate(false)
	$BeamTR.activate(false)
	$BeamTL.activate(false)
	$BeamBL.activate(false)
	$BeamH.activate(false)
	$BeamV.activate(false)
	
	set_color(1)

func _process(delta):
	delta *= Global.speed
	if Input.is_action_pressed("red"):
		activated = true
		if Input.is_action_just_pressed("red"):
			set_color(1)
			release_point()
			activate_point(real_pos)	
	elif Input.is_action_just_released("red"):
		activated = false
		release_point()
	
	if Input.is_action_pressed("blue"):
		activated = true
		if Input.is_action_just_pressed("blue"):
			set_color(0)
			release_point()
			activate_point(real_pos)	
	elif Input.is_action_just_released("blue"):
		activated = false
		release_point()
		
	if Input.is_action_pressed("cancel"):
		release()
	
	if Input.is_action_just_pressed("ui_up") and real_pos != Vector2(0, -1):
		real_pos = Vector2(0, -1)
		$ZoneTop.hover(true)
		$ZoneBottom.hover(false)
		$ZoneLeft.hover(false)
		$ZoneRight.hover(false)
		if activated:
			activate_point(real_pos)
	elif Input.is_action_just_pressed("ui_down") and real_pos != Vector2(0, 1):
		real_pos = Vector2(0, 1)
		$ZoneTop.hover(false)
		$ZoneBottom.hover(true)
		$ZoneLeft.hover(false)
		$ZoneRight.hover(false)
		if activated:
			activate_point(real_pos)
	elif Input.is_action_just_pressed("ui_left") and real_pos != Vector2(-1, 0):
		real_pos = Vector2(-1, 0)
		$ZoneTop.hover(false)
		$ZoneBottom.hover(false)
		$ZoneLeft.hover(true)
		$ZoneRight.hover(false)
		if activated:
			activate_point(real_pos)
	elif Input.is_action_just_pressed("ui_right") and real_pos != Vector2(1, 0):
		real_pos = Vector2(1, 0)
		$ZoneTop.hover(false)
		$ZoneBottom.hover(false)
		$ZoneLeft.hover(false)
		$ZoneRight.hover(true)
		if activated:
			activate_point(real_pos)

func activate_point(point: Vector2):
	if lines.size() >= 1:
		zones_to_beam[vec_to_zone[lines[-1]]][vec_to_zone[point]].activate(true)
		
	lines.append(point)
	vec_to_zone[point].activate(true)

func release():
	for point in lines:
		vec_to_zone[point].activate(false)
	
	$BeamBR.activate(false)
	$BeamTR.activate(false)
	$BeamTL.activate(false)
	$BeamBL.activate(false)
	$BeamH.activate(false)
	$BeamV.activate(false)
	
	lines.clear()

func release_point():
	var launched = false
	for beam in beams:
		if beam.activated:
			launch(beam)
			launched = true
			
	if launched:
		$LaunchSE.play()
		
	release()
	
func launch(beam: Node2D):
	var bl_ins = beam_launcher_sc.instance()
	bl_ins.size = beam.size
	bl_ins.angle = beam.rotation_degrees
	bl_ins.position = beam.position
	bl_ins.color = color
	add_child(bl_ins)
	
	if beam in [$BeamH, $BeamV]:
		bl_ins = beam_launcher_sc.instance()
		bl_ins.size = beam.size
		bl_ins.angle = beam.rotation_degrees + 180
		bl_ins.position = beam.position
		bl_ins.color = color
		add_child(bl_ins)
		
func set_color(c: int):
	color = c
	
	$BeamBR.set_color(c)
	$BeamTR.set_color(c)
	$BeamTL.set_color(c)
	$BeamBL.set_color(c)
	$BeamH.set_color(c)
	$BeamV.set_color(c)
	
	$ZoneTop.set_color(c)
	$ZoneBottom.set_color(c)
	$ZoneLeft.set_color(c)
	$ZoneRight.set_color(c)
	
	$Effect.color = c
	$Border.color = c

func restart():
	release()
	activated = false
