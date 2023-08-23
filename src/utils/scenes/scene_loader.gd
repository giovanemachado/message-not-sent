extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var sound_effects: AudioStreamPlayer = $SoundEffects

var ambience_main_menu = preload("res://src/Audio Assets/Ambient/Main Menu Ambience.wav")
var emerge_sound = preload("res://src/Audio Assets/UI/Emerging Button.wav")
var submerge_sound = preload("res://src/Audio Assets/UI/Submerge Button.wav")

var subm_destroyed_sound = preload("res://src/Audio Assets/Sub_/SUB  DESTROYED V1.wav")
var subm_destroyed1_sound = preload("res://src/Audio Assets/Sub_/SUB DESTROYED V2.wav")

var sub_screeching1_sound = preload("res://src/Audio Assets/Sub_/Screeches/Sub screeching 1 .wav")
var sub_screeching2_sound = preload("res://src/Audio Assets/Sub_/Screeches/Sub screeching 2.wav")
var sub_screeching3_sound = preload("res://src/Audio Assets/Sub_/Screeches/Sub screeching 3.wav")
var sub_screeching4_sound = preload("res://src/Audio Assets/Sub_/Screeches/Sub screeching 4.wav")
var sub_screeching5_sound = preload("res://src/Audio Assets/Sub_/Screeches/Sub screeching 5.wav")

var default_scene_path = "res://src/scenes/"
var is_submerge_scene = false

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
		
	is_submerge_scene = false
	
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
		is_submerge_scene = true
		scr_s()
		animation_player.play_backwards("dissolve")
		
	elif target == Globals.SCENES.DEATH:
		var sounds = [subm_destroyed1_sound, subm_destroyed_sound]
		sound_effects.stream = sounds.pick_random()
		sound_effects.play()
		await get_tree().create_timer(2).timeout
		animation_player.play_backwards("dissolve")
	else:
		animation_player.play_backwards("dissolve")


func scr_s():
	if !is_submerge_scene: return
	screeching_sounds()
	await get_tree().create_timer(randf_range(10, 25)).timeout
	scr_s()


func screeching_sounds():
	var sounds = [
		sub_screeching1_sound,
		sub_screeching2_sound,
		sub_screeching3_sound,
		sub_screeching4_sound,
		sub_screeching5_sound
	]
	
	sound_effects.stream = sounds.pick_random()
	sound_effects.play()
