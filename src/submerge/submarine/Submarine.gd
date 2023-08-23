extends CharacterBody2D

signal reached_end

@export var speed: float

@onready var commands = $"../Commands"

@onready var obs_detect = $ObstaclesDetector

@onready var canvas = $"../CanvasLayer"

var next_target: Vector2
var length: float = 0
var is_moving = false
var has_reached_end = false
var next_target_set = false
var is_first_mark = true

func _ready(): 
	has_reached_end = false
	canvas.hide()

func _physics_process(delta):
	if has_reached_end: return
	
	if !next_target_set:
		obs_detect.set_collision_mask_value(Globals.current_level - 1, false)
		obs_detect.set_collision_mask_value(Globals.current_level, true)
		next_target = commands.all_marks[commands.current_mark_index].position
		next_target_set = true
	
	if next_target.distance_to(global_position) < 5:
		if is_first_mark:
			canvas.show()
			is_first_mark = false
			
		velocity = Vector2.ZERO
		is_moving = false
		
		if commands.current_distance >= 3:
			reached_end.emit()
			has_reached_end = true
			canvas.hide()
	else:
		var target_position: Vector2 = next_target
		var direction = global_position.direction_to(target_position)
		velocity = direction * speed
		is_moving = true
		move_and_slide()


func _on_obstacles_detector_area_entered(area):
	if area.is_in_group(Globals.GROUPS.OBSTACLES):
		SceneLoader.scene_transition(Globals.SCENES.DEATH)
