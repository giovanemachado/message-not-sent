extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var sound_effects: AudioStreamPlayer2D = $SoundEffects

var ambience_main_menu = preload("res://src/Audio Assets/Ambient/Main Menu Ambience.wav")
var emerge_sound = preload("res://src/Audio Assets/UI/Emerging Button.wav")
var submerge_sound = preload("res://src/Audio Assets/UI/Submerge Button.wav")

var default_scene_path = "res://src/scenes/"


var tween: Tween
	
func scene_transition(target: String):
	animation_player.play("dissolve")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(default_scene_path + target + ".tscn")
	

	if tween:
		tween.kill()
		
	tween = create_tween()
	
	if audio_stream_player.playing:
		tween.tween_property(audio_stream_player, "volume_db", -80, 0.5)

	if target == Globals.SCENES.EMERGE:
		sound_effects.stream = emerge_sound
		sound_effects.play()
		
		audio_stream_player.stream = ambience_main_menu
		audio_stream_player.play()
		
		tween.tween_property(audio_stream_player, "volume_db", -8, 0.5)
		
		await get_tree().create_timer(4).timeout
		animation_player.play_backwards("dissolve")
	elif target == Globals.SCENES.SUBMERGE:
		sound_effects.stream = submerge_sound
		sound_effects.play()
		
#		audio_stream_player.stream = ambience_main_menu
#		audio_stream_player.play()
#
#		tween.tween_property(audio_stream_player, "volume_db", -8, 0.5)
		
		await get_tree().create_timer(4).timeout
		animation_player.play_backwards("dissolve")
	else:
		animation_player.play_backwards("dissolve")
