extends Node2D

@export var world_speed = 50

@onready var moving_environment = $Environment/Moving

var platform = preload("res://Scenes/platform.tscn")
var rng = RandomNumberGenerator.new()
var last_platform_position = Vector2.ZERO
var next_spawn_time = 0

func _ready():
	rng.randomize()
	
func _process(delta):
	if Time.get_ticks_msec() > next_spawn_time:
		_spawn_next_platform()
		
func _spawn_next_platform():
	var new_platform = platform.instantiate()
		
	if last_platform_position == Vector2.ZERO:
		new_platform.position = Vector2(400, 0)
	else:
		var x = last_platform_position.x + rng.randi_range(450, 550)
		var y = clamp(last_platform_position.y + rng.randi_range(-150, 150), 200, 1000)
		new_platform.position = Vector2(x, y)
		
	moving_environment.add_child(new_platform)
	
	last_platform_position = new_platform.position
	next_spawn_time += world_speed

func _physics_process(delta):
	moving_environment.position.x -= world_speed * delta
