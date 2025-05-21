extends CharacterBody2D

signal player_died
signal player_win

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_sound = $hitSound
@onready var jump_sound = $jumpSound
@onready var pickup_sound = $pickupSound

@export var SPEED = 100.0
@export var JUMP_VELOCITY = -300.0

#Comienza sin poderse mover
var can_move := false

var has_key := false

func _physics_process(delta: float) -> void:
	if not can_move:
		return
	
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump_sound.play()
		velocity.y = JUMP_VELOCITY

	# Movimiento horizontal con get_axis
	var direction = Input.get_axis("left", "right")
	velocity.x = direction * SPEED

	# Animación y volteo del sprite
	if direction != 0:
		animated_sprite_2d.play("run")
		animated_sprite_2d.flip_h = direction < 0  # Voltea si va a la izquierda
	else:
		animated_sprite_2d.play("idle")

	move_and_slide()

func death():
	player_died.emit()
	hit_sound.play()
	animated_sprite_2d.play("death")

func win():
	player_win.emit()
	animated_sprite_2d.play("celebration")
