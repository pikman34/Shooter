extends CharacterBody2D


@export var walk_speed = 150.0
@export var run_speed = 300.0
@export_range(0, 1) var accelertation = 0.1
@export_range(0, 1) var deceleration = 0.1
@export var jump_force = -400.0
@export_range(0, 1) var decelerate_on_jump_release = 0.5
@onready var gun = $Gun
@onready var camera = $"../Camera2D"

var shootdir = Vector2.ZERO

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	camera.position = position
	
	if Input.is_action_pressed("Shoot"):
		gun.shoot()
	
	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_force
	
	if Input.is_action_just_released("Jump") and velocity.y < 0:
		velocity.y *= decelerate_on_jump_release

	var speed
	if Input.is_action_pressed("Run"):
		speed = run_speed
	else:
		speed = walk_speed
	
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * speed, speed * accelertation)
	else:
		velocity.x = move_toward(velocity.x, 0, walk_speed * deceleration)
	
	shootdir.x = Input.get_axis("Left", "Right")
	shootdir.y = Input.get_axis("Up", "Down")
	
	if shootdir != Vector2.ZERO:
		gun.setup_direction(shootdir)
		
	
	
	if shootdir.y < 0:
		$Sprite/PlayerAnimation.play("lookup")
	elif shootdir.y > 0:
		$Sprite/PlayerAnimation.play("lookdown")
	else:
		$Sprite/PlayerAnimation.play("RESET")
	if shootdir.x < 0:
		$Sprite.flip_h = true
	if shootdir.x > 0:
		$Sprite.flip_h = false
	
	
	
	
	move_and_slide()
