extends Node2D

@onready var bg = $BG
@onready var timer_label = $CanvasLayer/CenterContainer/timerLabel
@onready var visible_timer = $visibleTimer
@onready var platforms = $Platforms
@onready var player = $player
@onready var camera_2d = $Camera2D
@onready var center_container = $CanvasLayer/CenterContainer

@export var visible_time: int = 3

func _ready():
	timer_label.text = str(visible_time)

func _on_visible_timer_timeout():
	if visible_time == 1:
		timer_label.queue_free()
		visible_timer.queue_free()
		make_platforms_invisible()
		player.can_move = true
		camera_2d.shake(5.0, 0.3)
	visible_time -= 1
	timer_label.text = str(visible_time)
	center_container.shake(5.0, 0.2)

func make_platforms_invisible():
	platforms.modulate.a = 0
