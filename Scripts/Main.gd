extends Node2D

onready var screen_shader = $CanvasLayer/RectMiddle.material
onready var score = $CanvasLayer/RectLeft/Score
onready var hiscore = $CanvasLayer/RectRight/HiScore
onready var speed = $CanvasLayer/RectLeft/Speed
onready var combos = $CanvasLayer/RectLeft/Combos
onready var level = $CanvasLayer/RectLeft/Level
var color = 0
var game_over = false
var intensity = 0

func _ready():
	speed.set_speed(Global.speed)
	level.set_level(1)
	var data = SaveUtilitly.load_file()
	hiscore.set_score(data["hiscore"])

func _process(delta):
	
	if !game_over:
		if Input.is_action_just_pressed("red"):
			set_color(1)
		elif Input.is_action_just_pressed("blue"):
			set_color(0)
	else:
		if Input.is_action_just_pressed("restart"):
			restart_game()
	
	intensity = lerp(intensity, 0, delta * 5)
	$CanvasLayer/RectMiddle.material.set_shader_param("intensity", intensity)

func score_combo_value():
	return int(100 + 10*combos.value + 10*$Diamond/Spawner.current_level)

func on_enemy_deleted():
	$CanvasLayer/RectRight/HealthBar.add_health(1)
	score.add(score_combo_value())
	combos.add(1)
	
func on_beam_lost():
	combos.reset()
	
func on_enemy_wrong():
	combos.reset()
	take_hit()

func _on_Diamond_area_entered(area: Area2D):
	area.delete(0)
	combos.reset()
	take_hit()
	
func game_over():
	Global.speed = 1
	$GameOver.show()
	$GameOver/FinalScore.text = "SCORE: " + str(score.value)
	$Diamond.set_process(false)
	$Diamond/Spawner.set_process(false)
	$Diamond/Spawner.delete_enemies()
	if score.value > hiscore.value:
		save_high_score(score.value)
		$GameOver/IsHighScore.show()
	else:
		$GameOver/IsHighScore.hide()
		
	game_over = true

func save_high_score(value: int):
	SaveUtilitly.save_file({"hiscore": value})
	hiscore.set_score(value)

func restart_game():
	$GameOver.hide()
	$Diamond.restart()
	$Diamond/Spawner.restart()
	$Diamond.set_process(true)
	$Diamond/Spawner.set_process(true)
	$CanvasLayer/RectRight/HealthBar.reset()
	score.reset()
	combos.reset()
	level.reset()
	speed.set_speed(Global.speed)
	level.set_level(1)
	game_over = false

func _on_Spawner_change_speed():
	speed.set_speed(Global.speed)
	
func set_color(c: int):
	$CanvasLayer/RectRight/HealthBar/Border.material.set_shader_param("alpha", c)
	$CanvasLayer/RectRight/HealthBar/Bar.material.set_shader_param("alpha", c)
	
func take_hit():
	$HitSE.play()
	$CanvasLayer/RectRight/HealthBar.take_hit(10)
	intensity = 4

func _on_HealthBar_zero_health():
	game_over()


func _on_Spawner_change_level(value: int):
	level.set_level(value + 1)
