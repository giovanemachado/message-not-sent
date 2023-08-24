extends Node2D


func _on_play_pressed():
	SceneLoader.scene_transition(Globals.SCENES.EMERGE)


func _on_credits_pressed():
	SceneLoader.scene_transition(Globals.SCENES.CREDITS)
