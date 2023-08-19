extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var default_scene_path = "res://src/scenes/"

var tween: Tween
	
func scene_transition(target: String):
	animation_player.play("dissolve")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(default_scene_path + target + ".tscn")
	animation_player.play_backwards("dissolve")
