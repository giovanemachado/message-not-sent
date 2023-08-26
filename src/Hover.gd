extends Node2D

@onready var area:Area2D = $Area2D
@onready var sprite_parent: Sprite2D = $".."

var is_disabled = false
var is_set = false
var max_size = Vector2()

var tween: Tween
var original: Vector2

func _ready():
	assert(area != null, "Missing area2d")
	area.mouse_entered.connect(mouse_hover)
	area.mouse_exited.connect(mouse_far)


func mouse_hover():
	if is_disabled: return
	
	if !is_set:
		max_size = Vector2(sprite_parent.scale.x + 0.3,  sprite_parent.scale.y + 0.3)
		original = sprite_parent.scale
		is_set = true
	
	if tween:
		tween.kill()
		
	tween = create_tween()
	
	tween.tween_property(sprite_parent, "scale", max_size, 0.1)
	
	
func mouse_far():
	if is_disabled: return
	
	if tween:
		tween.kill()
		
	tween = create_tween()
	
	tween.tween_property(sprite_parent, "scale", original, 0.05)

	
