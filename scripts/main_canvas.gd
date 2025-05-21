extends CanvasLayer

@onready var center_container: CenterContainer = $Control/CenterContainer
@onready var timer_label: Label = $Control/CenterContainer/timerLabel
@onready var dialogue_container: MarginContainer = $Control/dialogueContainer

var is_dialogue_active := false

func start_dialogue():
	dialogue_container.start_dialogue()

func shake_center_container(strength: float, duration: float):
	center_container.shake(strength, duration)
