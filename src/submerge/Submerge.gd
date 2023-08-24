extends Node2D

# 0 bottom, 1 middle, 2 top
@onready var start_mark_0 = $Gameplay/UtilMarks/Marker2D0
@onready var start_mark_1 = $Gameplay/UtilMarks/Marker2D1
@onready var start_mark_2 = $Gameplay/UtilMarks/Marker2D2

@onready var start_mark = $Gameplay/Mark1

@onready var areas_level_1 = $Environment/Obstacles/AreasLevel1
@onready var areas_level_2 = $Environment/Obstacles/AreasLevel2
@onready var areas_level_3 = $Environment/Obstacles/AreasLevel3
@onready var areas_level_4 = $Environment/Obstacles/AreasLevel4
@onready var areas_level_5 = $Environment/Obstacles/AreasLevel5

@onready var radar_level_1 = $CanvasLayer/Control/ColorRectRadar/Radar1
@onready var radar_level_2 = $CanvasLayer/Control/ColorRectRadar/Radar2
@onready var radar_level_3 = $CanvasLayer/Control/ColorRectRadar/Radar3
@onready var radar_level_4 = $CanvasLayer/Control/ColorRectRadar/Radar4
@onready var radar_level_5 = $CanvasLayer/Control/ColorRectRadar/Radar5

@onready var commands = $Commands

var current_level = 0

func _ready():
	current_level = Globals.current_level
	
	hide_levels()
	show_level()
	set_height_and_mark()


func set_height_and_mark():
	# heights 0 bottom, 1 middle, 2 top
	if current_level == 1:
		commands.current_height = 1
		start_mark.position = start_mark_1.position
		
	if current_level == 2:
		commands.current_height = 0
		start_mark.position = start_mark_0.position
		
	if current_level == 3:
		commands.current_height = 1
		start_mark.position = start_mark_1.position
		
	if current_level == 4:
		commands.current_height = 2
		start_mark.position = start_mark_2.position
		
	if current_level == 5:
		commands.current_height = 1
		start_mark.position = start_mark_1.position
	
#	print(" --------- level info --------- ")
#	print(current_level)
#	print(commands.current_height)
	

func show_level():
	if current_level == 1:
		areas_level_1.show()
		radar_level_1.show()
		
	if current_level == 2:
		areas_level_2.show()
		radar_level_2.show()
		
	if current_level == 3:
		areas_level_3.show()
		radar_level_3.show()
		
	if current_level == 4:
		areas_level_4.show()
		radar_level_4.show()
		
	if current_level == 5:
		areas_level_5.show()
		radar_level_5.show()

func hide_levels():
	areas_level_1.hide()
	radar_level_1.hide()
	
	areas_level_2.hide()
	radar_level_2.hide()
	
	areas_level_3.hide()
	radar_level_3.hide()
	
	areas_level_5.hide()
	radar_level_4.hide()
	
	areas_level_5.hide()
	radar_level_5.hide()

func _on_submarine_reached_end():
	Globals.current_level += 1
	
	if Globals.current_level > 5:
		Globals.current_level = 0
		SceneLoader.scene_transition(Globals.SCENES.GAME_OVER)
	else:
		SceneLoader.scene_transition(Globals.SCENES.EMERGE)
