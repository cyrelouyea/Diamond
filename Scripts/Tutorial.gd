extends Node2D

onready var text1 = $Label.text
onready var text2 = $Label2.text
onready var text3 = $Label3.text

var t = 0

func _ready():
	$Label3.text = ""
	$Label2.text = ""
	$Label.text = ""

func _process(delta):
	if t < 3:
		$Label3.text = text3.substr(0, int(min(text3.length() * t / 3, text3.length())))
	elif t < 6:
		$Label.text = text1.substr(0, int(min(text1.length() * (t-3) / 3, text1.length())))
		$Label3.text = text3.substr(0, int(min(text3.length() * t / 3, text3.length())))
	else:
		$Label2.text = text2.substr(0, int(min(text2.length() * (t-6) / 3, text2.length())))
		$Label.text = text1.substr(0, int(min(text1.length() * (t-3) / 3, text1.length())))
		$Label3.text = text3.substr(0, int(min(text3.length() * t / 3, text3.length())))
	
		
	if t > 15:
		modulate.a = 1.0 - (t - 15)
	t += delta
