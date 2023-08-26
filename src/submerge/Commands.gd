extends Node2D

# 0 is null
# 1 is the starter
# 2 3 4 middle
# 5 6 7 bottom
# 8 9 10 top
@onready var sub = $"../Submarine"
@export var all_marks: Array[Marker2D]
var current_mark_index = 1
var current_height = 1 #  0 bottom, 1 middle, 2 top # defined by Submerge script
var current_distance = 0 # 0 start, 1 middle, 2 end

@onready var button_up = $"../CanvasLayer/Control/ColorRectCommands/Sprite2D6"
@onready var button_forward = $"../CanvasLayer/Control/ColorRectCommands/Sprite2D2"
@onready var button_down = $"../CanvasLayer/Control/ColorRectCommands/Sprite2D4"
@onready var button_up_hover = $"../CanvasLayer/Control/ColorRectCommands/Sprite2D6/Hover"
@onready var button_forward_hover = $"../CanvasLayer/Control/ColorRectCommands/Sprite2D2/Hover"
@onready var button_down_hover = $"../CanvasLayer/Control/ColorRectCommands/Sprite2D4/Hover"

var disabled_color = Color("#595959")
var enabled_color = Color("#fff")

func _ready():
	if Globals.current_level == 1:
		button_up.modulate = enabled_color
		button_forward.modulate = enabled_color
		button_down.modulate = enabled_color
		button_up_hover.is_disabled = false
		button_forward_hover.is_disabled = false
		button_down_hover.is_disabled = false

	if Globals.current_level == 2:
		button_up.modulate = enabled_color
		button_forward.modulate = enabled_color
		button_down.modulate = disabled_color
		button_up_hover.is_disabled = false
		button_forward_hover.is_disabled = false
		button_down_hover.is_disabled = true
		
	if Globals.current_level == 3:
		button_up.modulate = enabled_color
		button_forward.modulate = enabled_color
		button_down.modulate = enabled_color
		button_up_hover.is_disabled = false
		button_forward_hover.is_disabled = false
		button_down_hover.is_disabled = false
		
	if Globals.current_level == 4:
		button_up.modulate = disabled_color
		button_forward.modulate = enabled_color
		button_down.modulate = enabled_color
		button_up_hover.is_disabled = true
		button_forward_hover.is_disabled = false
		button_down_hover.is_disabled = false
		
	if Globals.current_level == 5:
		button_up.modulate = enabled_color
		button_forward.modulate = enabled_color
		button_down.modulate = enabled_color
		button_up_hover.is_disabled = false
		button_forward_hover.is_disabled = false
		button_down_hover.is_disabled = false

func _on_up_button_pressed():
	if sub.is_moving: return
	
	var f = 1
	var i = get_next(f)
	if i == null: return
	update_marks(i, f)
	sub.next_target = all_marks[current_mark_index].position


func _on_forward_button_pressed():
	if sub.is_moving: return
	
	var f = 0
	var i = get_next(f)
	if i == null: return
	update_marks(i, f)
	sub.next_target = all_marks[current_mark_index].position


func _on_down_button_pressed():
	if sub.is_moving: return
	
	var f = -1
	var i = get_next(f)
	
	if i == null: return
	
	update_marks(i, f)
	sub.next_target = all_marks[current_mark_index].position
	

func get_next(f):
	var possibilities: Array[int]
	var next_height = current_height + f
	
	# 0 bottom, 1 middle, 2 top
	if next_height == 0:
		possibilities = [5,6,7]
		button_up.modulate = enabled_color
		button_forward.modulate = enabled_color
		button_down.modulate = disabled_color
		
		button_up_hover.is_disabled = false
		button_forward_hover.is_disabled = false
		button_down_hover.is_disabled = true

	elif next_height == 1:
		possibilities = [2,3,4]
		button_up.modulate = enabled_color
		button_forward.modulate = enabled_color
		button_down.modulate = enabled_color
		
		button_up_hover.is_disabled = false
		button_forward_hover.is_disabled = false
		button_down_hover.is_disabled = false
	elif next_height == 2:
		possibilities = [8,9,10]
		button_up.modulate = disabled_color
		button_forward.modulate = enabled_color
		button_down.modulate = enabled_color
		button_up_hover.is_disabled = true
		button_forward_hover.is_disabled = false
		button_down_hover.is_disabled = false
	else:
		return null
	
	return possibilities[current_distance]
	
func update_marks(i, h):
	current_mark_index = i
	current_height += h
	current_distance += 1
	
