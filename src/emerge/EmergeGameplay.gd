extends Node2D


@onready var contacts_screen = $Phone/Contacts
@onready var message_screen = $Phone/Message
@onready var animation_player: AnimationPlayer = $Phone/Message/AnimationPlayer
@onready var write_label = $Phone/Message/WriteBox/WriteLabel
@onready var message_tracking = $MessagesTracking

var current_contact: String = ""
var current_level: int = 1
var write_clicked = false
var write_done = false
var message_sent = false
var can_dive = false
var stopped_typing = false


var message_box_scene = preload("res://src/emerge/messages/message_box_scene.tscn")

const ANIMATIONS = {
	TYPE = 'typing',
}

@onready var sound_effects = $"../SoundEffects"

var msg_inc_sound = preload("res://src/Audio Assets/UI/Phone/MSG Inc .wav")
var msg_send_sound = preload("res://src/Audio Assets/UI/Phone/MSG send.wav")
var menu_click_sound = preload("res://src/Audio Assets/UI/Phone/Click Menu Hover.wav")
var select_sound = preload("res://src/Audio Assets/UI/Phone/Select.wav")

var type1_sound = preload("res://src/Audio Assets/UI/Phone/Click Keyboard High.wav")
var type2_sound = preload("res://src/Audio Assets/UI/Phone/Click Keyboard Low.wav")

@onready var daughter_level_1 = $Phone/Message/DaughterLevel1
@onready var daughter_level_1_sent = $Phone/Message/DaughterLevel1_Sent

@onready var boss_level_1 = $Phone/Message/BossLevel1

@onready var daughter_level_2 = $Phone/Message/DaughterLevel2
@onready var daughter_level_2_sent = $Phone/Message/DaughterLevel2_Sent

@onready var daughter_level_3 = $Phone/Message/DaughterLevel3
@onready var daughter_level_3_sent = $Phone/Message/DaughterLevel3_Sent

@onready var boss_level_3 = $Phone/Message/BossLevel3

@onready var daughter_level_4 = $Phone/Message/DaughterLevel4
@onready var daughter_level_4_sent = $Phone/Message/DaughterLevel4_Sent

@onready var daughter_level_5 = $Phone/Message/DaughterLevel5
@onready var daughter_level_5_sent = $Phone/Message/DaughterLevel5_Sent

@onready var commands = $Commands

@onready var tutorial = $Phone/Tutorial

func _ready():
	contacts_screen.show()
	message_screen.hide()
	write_clicked = false
	message_sent = false
	stopped_typing = false
	can_dive = false
	current_level = Globals.current_level
	commands.hide()
	
	if current_level == 1:
		tutorial.show()
	else:
		tutorial.hide()
	
	await get_tree().create_timer(5).timeout
	sound_effects.stream = msg_inc_sound
	sound_effects.play()
	
func _on_submerge_button_pressed():
	if !can_dive: return
	
	SceneLoader.scene_transition(Globals.SCENES.SUBMERGE)


func _on_write_button_pressed():
	if current_contact != Globals.CHARACTERS.DAUGHTER:
		return
		
	if write_clicked:
		return
		
	if message_sent:
		return
	
	if current_level == 1:
		write_message_then_erase(message_tracking.man_messages[0], message_tracking.man_messages[1])
	
	if current_level == 2:
		write_single_message(message_tracking.man_messages[2])
		
	if current_level == 3:
		write_single_message(message_tracking.man_messages[3])
		
	if current_level == 4:
		write_message_then_erase(message_tracking.man_messages[4], message_tracking.man_messages[5])
		
	if current_level == 5:
		write_single_message(message_tracking.man_messages[6])


func write_single_message(message):
	play_typing()
	write_clicked = true
	write_label.text = message
	animation_player.play(ANIMATIONS.TYPE)
	
	await animation_player.animation_finished
	write_done = true
	
	
func write_message_then_erase(message1, message2):
	play_typing()
	write_clicked = true
	write_label.text = message1
	animation_player.play(ANIMATIONS.TYPE)
	
	await animation_player.animation_finished
	stopped_typing = true
	await get_tree().create_timer(2).timeout
	stopped_typing = false
	animation_player.play_backwards(ANIMATIONS.TYPE)
	
	await animation_player.animation_finished
	play_typing()
	write_label.text = message2
	
	animation_player.play(ANIMATIONS.TYPE)
	await animation_player.animation_finished
	write_done = true


func _on_send_button_pressed():
	if current_contact != Globals.CHARACTERS.DAUGHTER:
		return
		
	if !write_done:
		return
		
	sound_effects.stream = msg_send_sound
	sound_effects.play()
	message_sent = true
	can_dive = true
	commands.show()
	update_messages()


func _on_contact_1_button_pressed():
	sound_effects.stream = select_sound
	sound_effects.play()
	contacts_screen.hide()
	current_contact = Globals.CHARACTERS.DAUGHTER
	update_messages()
	message_screen.show()


func _on_contact_2_button_pressed():
	sound_effects.stream = select_sound
	sound_effects.play()
	contacts_screen.hide()
	current_contact = Globals.CHARACTERS.BOSS
	update_messages()
	message_screen.show()


func _on_contacts_button_pressed():
	sound_effects.stream = menu_click_sound
	sound_effects.play()
	contacts_screen.show()
	message_screen.hide()


func update_messages():
	write_label.text = ''
	if current_contact == Globals.CHARACTERS.DAUGHTER:
		show_daughter_messages()
	else:
		hide_daughter_messages()
	
	if current_contact == Globals.CHARACTERS.BOSS:
		if current_level < 3:
			boss_level_1.show()
		if current_level >= 3:
			boss_level_3.show()
	else:
		boss_level_1.hide()
		boss_level_3.hide()


func show_daughter_messages():
	if current_level == 1:
		if message_sent:
			daughter_level_1.hide()
			daughter_level_1_sent.show()
		else:
			daughter_level_1.show()
			daughter_level_1_sent.hide()
	
	if current_level == 2:
		if message_sent:
			daughter_level_2.hide()
			daughter_level_2_sent.show()
		else:
			daughter_level_2.show()
			daughter_level_2_sent.hide()
	
	if current_level == 3:
		if message_sent:
			daughter_level_3.hide()
			daughter_level_3_sent.show()
		else:
			daughter_level_3.show()
			daughter_level_3_sent.hide()
	
	if current_level == 4:
		if message_sent:
			daughter_level_4.hide()
			daughter_level_4_sent.show()
		else:
			daughter_level_4.show()
			daughter_level_4_sent.hide()
			
	if current_level == 5:
		if message_sent:
			daughter_level_5.hide()
			daughter_level_5_sent.show()
		else:
			daughter_level_5.show()
			daughter_level_5_sent.hide()


func hide_daughter_messages():
	daughter_level_1.hide()
	daughter_level_1_sent.hide()
	daughter_level_2.hide()
	daughter_level_2_sent.hide()
	daughter_level_3.hide()
	daughter_level_3_sent.hide()
	daughter_level_4.hide()
	daughter_level_4_sent.hide()
	daughter_level_5.hide()
	daughter_level_5_sent.hide()

func play_typing():
	if write_done: return
	if stopped_typing: return
	var sounds = [type1_sound, type2_sound]
	sound_effects.stream = sounds.pick_random()
	sound_effects.play()
	await sound_effects.finished
	play_typing2()
	
func play_typing2():
	if write_done: return
	if stopped_typing: return
	var sounds = [type1_sound, type2_sound]
	sound_effects.stream = sounds.pick_random()
	sound_effects.play()
	await sound_effects.finished
	play_typing()
