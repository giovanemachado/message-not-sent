extends CharacterBody2D

@export var speed: float

@onready var mark1 = $"../Gameplay/Mark1"
var next_target: Vector2 = mark1.position
var length: float = 0
var is_moving = false

func _physics_process(delta):
	if next_target.distance_to(global_position) < 0.5:
		velocity = Vector2.ZERO
		is_moving = false
	else:
		var target_position: Vector2 = next_target
		var direction = global_position.direction_to(target_position)
		velocity = direction * speed
		is_moving = true

	move_and_slide()
