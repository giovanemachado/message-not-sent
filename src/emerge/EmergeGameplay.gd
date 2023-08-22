extends Node2D


@onready var contacts_screen = $Phone/Contacts
@onready var message_screen = $Phone/Message
#@onready var message_container = $Phone/Message/CanvasLayer/MarginContainer/VBoxContainer
@onready var animation_player: AnimationPlayer = $Phone/Message/AnimationPlayer
@onready var write_label = $Phone/Message/WriteBox/WriteLabel
@onready var message_tracking = $MessagesTracking

var current_contact: String = ""
var current_level: int = 1
var write_clicked = false
var write_done = false
var message_sent = false
var can_dive = false

var message_box_scene = preload("res://src/emerge/messages/message_box_scene.tscn")

const ANIMATIONS = {
	TYPE = 'typing',
}

@onready var daughter_level_1 = $Phone/Message/DaughterLevel1
@onready var daughter_level_1_sent = $Phone/Message/DaughterLevel1_Sent
@onready var boss_level_1 = $Phone/Message/BossLevel1

func _ready():
	contacts_screen.show()
	message_screen.hide()
	write_clicked = false
	message_sent = false
	can_dive = false
	current_level = Globals.current_level
	
func _on_submerge_button_pressed():
#	if !can_dive: return
	
	SceneLoader.scene_transition(Globals.SCENES.SUBMERGE)


func _on_write_button_pressed():
	if current_contact != Globals.CHARACTERS.DAUGHTER:
		return
		
	if write_clicked:
		return
		
	if message_sent:
		return
	
	if current_level == 1:
		write_clicked = true
		write_label.text = message_tracking.man_messages[0]
		animation_player.play(ANIMATIONS.TYPE)
		
		await animation_player.animation_finished
		await get_tree().create_timer(2).timeout
		animation_player.play_backwards(ANIMATIONS.TYPE)
		
		await animation_player.animation_finished
		write_label.text = message_tracking.man_messages[1]
		
		animation_player.play(ANIMATIONS.TYPE)
		write_done = true


func _on_send_button_pressed():
	if current_contact != Globals.CHARACTERS.DAUGHTER:
		return
		
	if !write_done:
		return
	
	message_sent = true
	can_dive = true
	update_messages()


func _on_contact_1_button_pressed():
	contacts_screen.hide()
	current_contact = Globals.CHARACTERS.DAUGHTER
	update_messages()
	message_screen.show()


func _on_contact_2_button_pressed():
	contacts_screen.hide()
	current_contact = Globals.CHARACTERS.BOSS
	update_messages()
	message_screen.show()


func _on_contacts_button_pressed():
	contacts_screen.show()
	message_screen.hide()

func update_messages():
	write_label.text = ''
	if current_contact == Globals.CHARACTERS.DAUGHTER:
		if current_level == 1:
			if message_sent:
				daughter_level_1.hide()
				daughter_level_1_sent.show()
			else:
				daughter_level_1.show()
				daughter_level_1_sent.hide()
	else:
		daughter_level_1.hide()
		daughter_level_1_sent.hide()
	
	if current_contact == Globals.CHARACTERS.BOSS:
		if current_level == 1:
			boss_level_1.show()
	else:
		boss_level_1.hide()
