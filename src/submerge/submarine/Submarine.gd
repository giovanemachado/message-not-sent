extends CharacterBody2D

signal reached_end

@export var speed: float

@onready var commands = $"../Commands"

@onready var obs_detect = $ObstaclesDetector

@onready var canvas = $"../CanvasLayer"
@onready var stream_player = $"../AudioStreamPlayer"
var sub_motor_sound1 = preload("res://src/Audio Assets/Sub_/Sub Engine Idle.wav")
var sub_motor_sound2 = preload("res://src/Audio Assets/Sub_/Sub Engine Loaded.wav")
var sub_motor_sound3 = preload("res://src/Audio Assets/Sub_/Sub Engine Mid.wav")

var tween: Tween
var next_target: Vector2
var length: float = 0
var is_moving = false
var has_reached_end = false
var next_target_set = false
var is_first_mark = true

func _ready(): 
	has_reached_end = false
	canvas.hide()
	play_mid_motor()

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
		play_idle_motor()
		
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
		play_load_motor()

func play_idle_motor():
	if stream_player.stream != sub_motor_sound1:
		stream_player.stream = sub_motor_sound1
		stream_player.play()
	
func play_mid_motor():
	if stream_player.stream != sub_motor_sound3:
		stream_player.stream = sub_motor_sound3
		stream_player.play()
		
func play_load_motor():
	if stream_player.stream != sub_motor_sound2:
		stream_player.stream = sub_motor_sound2
		stream_player.play()

func _on_obstacles_detector_area_entered(area):
	if area.is_in_group(Globals.GROUPS.OBSTACLES):
		SceneLoader.destroyed_by_obstacle()
	if area.is_in_group(Globals.GROUPS.MINES):
		SceneLoader.destroyed_by_mine()
