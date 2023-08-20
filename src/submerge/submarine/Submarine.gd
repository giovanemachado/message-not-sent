extends CharacterBody2D

@export var speed: float

@onready var mark1 = $"../Gameplay/Mark1"
@onready var commands = $"../Commands"
var next_target: Vector2
var length: float = 0
var is_moving = false

func _ready():
	next_target = commands.all_marks[commands.current_mark_index].position

func _physics_process(delta):
	if next_target.distance_to(global_position) < 2:
		velocity = Vector2.ZERO
		is_moving = false
		
		if commands.current_distance >= 3:
			SceneLoader.scene_transition(Globals.SCENES.EMERGE)
	else:
		var target_position: Vector2 = next_target
		var direction = global_position.direction_to(target_position)
		velocity = direction * speed
		is_moving = true
		move_and_slide()


func _on_obstacles_detector_area_entered(area):
	if area.is_in_group(Globals.GROUPS.OBSTACLES):
		SceneLoader.scene_transition(Globals.SCENES.DEATH)
