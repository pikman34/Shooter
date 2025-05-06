extends Node2D

@export var world_speed = 300

@onready var moving_environment = $Environment/Moving

var platform = preload("res://Scenes/platform.tscn")
var rng = RandomNumberGenerator.new()

func _physics_process(delta):
	moving_environment.position.x -= world_speed * delta
