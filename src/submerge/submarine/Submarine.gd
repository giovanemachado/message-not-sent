extends CharacterBody2D

signal reached_end

@export var speed: float

@onready var commands = $"../Commands"
var next_target: Vector2
var length: float = 0
var is_moving = false
var has_reached_end = false

var next_target_set = false

func _ready(): 
	has_reached_end = false
	# next_target = commands.all_marks[commands.current_mark_index].position
	collision_mask = Globals.current_level

func _physics_process(delta):
	if has_reached_end: return
	
	if !next_target_set:
		next_target = commands.all_marks[commands.current_mark_index].position
		next_target_set = true
	
	if next_target.distance_to(global_position) < 5:
		velocity = Vector2.ZERO
		is_moving = false
		
		if commands.current_distance >= 3:
			reached_end.emit()
			has_reached_end = true
	else:
		var target_position: Vector2 = next_target
		var direction = global_position.direction_to(target_position)
		velocity = direction * speed
		is_moving = true
		move_and_slide()


func _on_obstacles_detector_area_entered(area):
	if area.is_in_group(Globals.GROUPS.OBSTACLES):
		SceneLoader.scene_transition(Globals.SCENES.DEATH)
