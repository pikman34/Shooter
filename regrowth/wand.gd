extends Node2D

@export var shotSpeed = 1.0
const BULLET = preload("res://Scenes/bullet.tscn")
@onready var marker_2d = $Marker2D
@onready var shoot_speed_timer = $shotSpeedTimer

var canShoot = true
var bulletDirection = Vector2(1,0)

func _ready():
	shoot_speed_timer.wait_time = 1.0 / shotSpeed
	
func shoot():
	if canShoot:
		canShoot = false
		shoot_speed_timer.start()
		
		var bulletNode = BULLET.instantiate()
		
		bulletNode.set_direction(bulletDirection)
		get_tree().root.add_child(bulletNode)
		bulletNode.global_position = marker_2d.global_position

func _on_shot_speed_timer_timeout() -> void:
	canShoot = true
	
func setup_direction(direction):
	bulletDirection = direction
	
	if direction.x > 0:
		scale.x = 1
		rotation_degrees = 0
	elif direction.x < 0:
		scale.x = -1
		rotation_degrees = 0
	elif direction.y < 0:
		scale.x = 1
		rotation_degrees = -90
	elif direction.y > 0:
		scale.x = 1
		rotation_degrees = 90
