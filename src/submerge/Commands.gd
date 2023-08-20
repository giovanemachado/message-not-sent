extends Node2D

# 0 is null
# 1 is the starter
# 2 3 4 middle
# 5 6 7 bottom
# 8 9 10 top
@onready var sub = $"../Submarine"
@export var all_marks: Array[Marker2D]
var current_mark_index = 1
var current_height = 1 #  0 bottom, 1 middle, 2 top
var current_distance = 0 # 0 start, 1 middle, 2 end

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
	
	if next_height == 0:
		possibilities = [5,6,7]
	elif next_height == 1:
		possibilities = [2,3,4]
	elif next_height == 2:
		possibilities = [8,9,10]
	else:
		return null
	
	return possibilities[current_distance]
	
func update_marks(i, h):
	current_mark_index = i
	current_height += h
	current_distance += 1
	
