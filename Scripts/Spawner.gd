extends Node2D

signal change_speed
signal change_level

export var enemy_sc: PackedScene
export var circle_sc: PackedScene

var patterns: Array
var timer = 0
var current_level = 0
var current_pattern = 0
var current_element = -1
var nb_levels = 0
var level_speed = 0
var current = null
var random = false
var i = 0

var fallback_patterns = [
[
[
[2,"r","TR"],
[2,"r","BR"],
[2,"r","BL"],
[2,"r","TL"],
[2,"r","T","B"],
[2,"r","L","R"],
],
[
[2,"b","TR"],
[2,"b","BR"],
[2,"b","BL"],
[2,"b","TL"],
[2,"b","T","B"],
[2,"b","L","R"],
],
],
[
[
[2,"r","TR","TL"],
[2,"r","BR","BL"],
[2,"r","BL","R","L"],
[2,"r","TL","T","B"],
[2,"r","TR","TL"],
[2,"r","TR","TL"],
],
[
[2,"b","TR","TL"],
[2,"b","BR","BL"],
[2,"b","BL","R","L"],
[2,"b","TL","T","B"],
[2,"b","TR","TL"],
[2,"b","TR","TL"],
],
[
[2,"r","TR","TL","BR","BL"],
[2,"b","TR","TL","BR","BL"],
[2,"r","TR","TL","BR","BL"],
[2,"b","TR","TL","BR","BL"],
[2,"r","T","B"],
[2,"b","L","R"],
],
[
[2,"r","TR","TL","L","R"],
[2,"r","BR","BL","L","R"],
[2,"b","TR","BR","T","B"],
[2,"b","TL","BL","T","B"],
[2,"r","TR","T","B"],
[2,"r","BL","BR"],
[2,"b","TR","TL","L","R"],
[2,"b","BR","BL","L","R"],
[2,"r","TR","BR","T","B"],
[2,"r","TL","BL","T","B"],
[2,"b","TR","T","B"],
[2,"b","BL","BR"],
],
],
[
[
[2,"r","L","R","BR","T","B","TL"],
[2,"r","TL","BL"],
[2,"b","BL","BR"],
[2,"r","TL","TR","BL","BR"],
[1.5,"b","TL","TR","BL","BR"],
[1.5,"r","TL","TR","BL","BR"],
[1.5,"b","TL","TR","BL","BR"],
[2,"b","L","R","BR","T","B","TL"],
[2,"b","TL","TR"],
[2,"r","TR","BR"],
[2,"b","TL","TR","BL","BR"],
[1.5,"r","TL","TR","BL","BR"],
[1.5,"b","TL","TR","BL","BR"],
[1.5,"r","TL","TR","BL","BR"],
],
[
[2,"r","T","B"],
[1,"b","T","B"],
[1,"r","T","B"],
[1,"b","T","B"],
[1,"b","L","R"],
[1,"r","L","R"],
[1,"b","L","R"],
[1,"r","L","R"],
[1,"r","L","R"],
[1,"b","T","B"],
[1,"b","L","R"],
[1,"r","T","B"],
[1,"b","T","B"],
[1,"r","L","R"],
[1,"r","L","R"],
[1,"b","T","B"],
],
[
[2,"r","T","B","BR","BL"],
[2,"r","T","B","TR","TL"],
[2,"b","L","R","BR","TR"],
[2,"b","L","R","BL","TL"],
[1,"r","TR","TL","BL","BR"],
[1,"b","TR","TL","BL","BR"],
[2,"r","T","B","BR","BL"],
[2,"r","T","B","TR","TL"],
[2,"b","L","R","BR","TR"],
[2,"b","L","R","BL","TL"],
[1,"r","TR"],
[1,"r","TL"],
[1,"r","BL"],
[1,"r","BR"],
],
[
[2,"r","L","R","TR"],
[2,"r","TR","T","B"],
[2,"r","T","B","BL"],
[2,"r","BL","L","R"],
[2,"r","TR","TL","BL","BR"],
[2,"b","L","R","TR"],
[2,"b","TR","T","B"],
[2,"b","T","B","BL"],
[2,"b","BL","L","R"],
],
],
[
[
[2,"r","TR","TL","BL","BR","T","B"],
[2,"b","TR","TL","BL","BR","T","B"],
[2,"r","TR","TL","BL","BR","L","R"],
[2,"b","TR","TL","BL","BR","L","R"],
[2,"r","TR","TL","BL","BR","L","R"],
[2,"r","TR","TL","BL","BR","T","B"],
[2,"b","TR","TL","BL","BR","L","R","T","B"],
[2,"b","TR","TL","BL","BR","L","R"],
],
[
[1,"r","TR","TL"],
[1,"b","TL","BL"],
[1,"r","BL","L","R"],
[1,"b","L","R"],
[1,"b","L","R"],
[1,"b","L","R"],
[1,"b","L","R"],
[1,"r","T","B"],
[1,"r","T","B"],
[1,"r","T","B"],
[1,"r","T","B"],
[2,"r","TR","TL","BL"],
[2,"r","BR","TR","TL"],
[2,"r","TL","BL","BR"],
[2,"b","TR","TL","BL"],
[2,"b","BR","TR","TL"],
[2,"b","TL","BL","BR"],
],
[
[2,"r","T","B","BR","BL"],
[2,"r","T","B","TR","TL"],
[2,"b","L","R","BR","TR"],
[2,"b","L","R","BL","TL"],
[1,"r","TR","TL","BL","BR"],
[1,"b","TR","TL","BL","BR"],
[2,"r","T","B","BR","BL"],
[2,"r","T","B","TR","TL"],
[2,"b","L","R","BR","TR"],
[2,"b","L","R","BL","TL"],
[1,"r","TR"],
[1,"r","TL"],
[1,"r","BL"],
[1,"r","BR"],
],
[
[2,"r","L","R","TR"],
[2,"r","TR","T","B"],
[2,"r","T","B","BL"],
[2,"r","BL","L","R"],
[2,"r","TR","TL","BL","BR"],
[2,"b","L","R","TR"],
[2,"b","TR","T","B"],
[2,"b","T","B","BL"],
[2,"b","BL","L","R"],
],
[
[1,"r","T","B"],
[1,"b","L","R"],
[2,"r","TR","TL"],
[1,"r","T","B"],
[1,"b","L","R"],
[2,"b","TL","BL"],
[1,"r","T","B"],
[1,"b","L","R"],
[2,"r","BL","BR"],
[1,"r","T","B"],
[1,"b","L","R"],
[2,"b","BR","TR"],
[1,"r","T","B"],
[1,"b","L","R"],
],
],
]

var tutorial = true
export var tuto_time = 15

func _ready():
	patterns = get_patterns_by_level("Patterns")
	nb_levels = patterns.size()
	current = change_pattern()
	
	
func _process(delta):
	delta *= Global.speed
	
	if tutorial:
		tuto_time -= delta
		if tuto_time < 0:
			tutorial = false
			timer = 0
		return
			
	if timer >= float(current[0]):
		spawn_pattern(current)
		current = change_pattern()
		timer = 0
	
	timer += delta
	
func restart():
	current_level = 0
	current_pattern = 0
	current_element = -1
	level_speed = 0
	i = 0
	random = false
	current = change_pattern()

func delete_enemies():
	for node in get_children():
		node.delete(0)
		
func change_pattern():
	current_element += 1
	if current_element >= patterns[current_level][current_pattern].size():
		current_element = 0
		if random:
			i += 1
			current_pattern = randi() % patterns[current_level].size()
			if i > patterns.size():
				Global.speed += 0.2
				emit_signal("change_speed")
				level_speed += 1
				i = 0
		else:
			current_pattern += 1
			if current_pattern >= patterns[current_level].size():
				current_pattern = 0
				current_level += 1
				emit_signal("change_level", current_level)
				if current_level >= patterns.size():
					current_level -= 1
					random = true
					Global.speed += 0.2
					emit_signal("change_speed")
					level_speed += 1
	return patterns[current_level][current_pattern][current_element]
	

func spawn_pattern(pattern: Array):
	spawn_circle(1 if pattern[1] == "r" else 0)
	for i in range(2, pattern.size()):
		var sc = pattern[i]
		var en_ins = enemy_sc.instance()
		en_ins.direction = pattern[i]
		en_ins.color = 1 if pattern[1] == "r" else 0
		add_child(en_ins)

func spawn_circle(color: int):
	var circle_ins = circle_sc.instance()
	circle_ins.color = color
	add_child(circle_ins)
	
func get_patterns_by_level(path):
	var dir = Directory.new()
	var patterns = []
	if dir.open(path) == OK:
		dir.list_dir_begin(true, true)
		var filename = dir.get_next()
		while filename != "":
			if dir.current_is_dir():
				patterns.append(get_patterns_from_level(path + "/" + filename))
			filename = dir.get_next()
	else:
		patterns = fallback_patterns
	return patterns

func get_patterns_from_level(path):
	var dir = Directory.new()
	var patterns = []
	if dir.open(path) == OK:
		dir.list_dir_begin(true, true)
		var filename = dir.get_next()
		while filename != "":
			if !dir.current_is_dir():
				patterns.append(get_pattern_from_file(path + "/" + filename))
			filename = dir.get_next()
	else:
		OS.alert("An error occurred when trying to load patterns.")
		get_tree().quit()
	return patterns
	
func get_pattern_from_file(path):
	var file = File.new()
	var elements = []  
	if file.open(path, File.READ) == OK:
		var content = file.get_as_text()
		for line in content.split("\n"):
			elements.append(line.split(" "))
	else:
		OS.alert("An error occurred when trying to load patterns.")
		get_tree().quit()
	return elements
		
	
	
