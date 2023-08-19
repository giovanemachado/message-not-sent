extends Node2D


func _on_play_pressed():
	SceneLoader.scene_transition(Globals.SCENES.GAME)


func _on_credits_pressed():
	SceneLoader.scene_transition(Globals.SCENES.CREDITS)


func _on_tutorial_pressed():
	SceneLoader.scene_transition(Globals.SCENES.TUTORIAL)
