extends Node2D

func _on_play_again_pressed():
	SceneLoader.scene_transition(Globals.SCENES.SUBMERGE)
