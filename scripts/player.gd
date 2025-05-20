extends CharacterBody2D

signal player_died
signal player_win

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var SPEED = 100.0
@export var JUMP_VELOCITY = -300.0

#Comienza sin poderse mover
var can_move := false

func _physics_process(delta: float) -> void:
	if not can_move:
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
		animated_sprite_2d.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite_2d.play("idle")

	move_and_slide()

func death():
	player_died.emit()
	animated_sprite_2d.play("death")

func win():
	player_win.emit()
	animated_sprite_2d.play("celebration")
