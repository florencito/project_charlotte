extends Node2D

@onready var bg = $BG
@onready var timer_label = $CanvasLayer/CenterContainer/timerLabel
@onready var visible_timer = $visibleTimer
@onready var invisible_objects: Node2D = $invisibleObjects
@onready var player = $player
@onready var camera_2d = $Camera2D
@onready var center_container = $CanvasLayer/CenterContainer

@export var visible_time: int = 3

func _ready():
	timer_label.text = str(visible_time)

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		restart()

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
	invisible_objects.modulate.a = 0

func _on_player_player_died() -> void:
	player.can_move = false
	camera_2d.shake(5.0, 0.2)
	var restart_timer = Timer.new()
	restart_timer.wait_time = 2
	restart_timer.one_shot = true
	restart_timer.timeout.connect(restart)
	add_child(restart_timer)
	restart_timer.start()

func restart():
	get_tree().reload_current_scene()

func _on_player_player_win() -> void:
	player.can_move = false
	print("YOU WON")
