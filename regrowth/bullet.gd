extends Area2D

@export var speed = 750
@export var damage = 15

var shootdir:Vector2

func _ready():
	await get_tree().create_timer(3).timeout
	queue_free()

func set_direction(bulletDirection):
	shootdir = bulletDirection
	rotation_degrees = rad_to_deg(global_position.angle_to_point(global_position*shootdir))
	
	
func _physics_process(delta):
	global_position += shootdir * speed * delta


func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.get_damage(damage)
		queue_free()
	if body.is_in_group("platforms"):
		queue_free()
