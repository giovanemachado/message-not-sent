extends Node2D

# 0 bottom, 1 middle, 2 top
@onready var start_mark_0 = $Gameplay/UtilMarks/Marker2D0
@onready var start_mark_1 = $Gameplay/UtilMarks/Marker2D1
@onready var start_mark_2 = $Gameplay/UtilMarks/Marker2D2

@onready var start_mark = $Gameplay/Mark1

@onready var areas_level_1 = $Environment/Obstacles/AreasLevel1
@onready var areas_level_2 = $Environment/Obstacles/AreasLevel2

@onready var commands = $Commands

var current_level = 0

func _ready():
	current_level = Globals.current_level
	areas_level_1.hide()
	areas_level_2.hide()

	if current_level == 1:
		areas_level_1.show()
#		areas_level_1.disabled = false
		# 0 bottom, 1 middle, 2 top
		commands.current_height = 1
		start_mark.position = start_mark_1.position
	if current_level == 2:
		areas_level_2.show()
#		areas_level_2.disabled = false
		commands.current_height = 0
		start_mark.position = start_mark_0.position


func _on_submarine_reached_end():
	Globals.current_level += 1
	SceneLoader.scene_transition(Globals.SCENES.EMERGE)
