extends Node2D


@onready var contacts_screen = $Phone/Contacts
@onready var message_screen = $Phone/Message
@onready var message_container = $Phone/Message/CanvasLayer/MarginContainer/VBoxContainer
@onready var animation_player: AnimationPlayer = $Phone/Message/AnimationPlayer
@onready var write_label = $Phone/Message/WriteLabel
@onready var message_tracking = $MessagesTracking

var current_contact: String = ""
var current_level: int = 1
var write_clicked = false
var can_send = false
var can_dive = false

var message_box_scene = preload("res://src/emerge/messages/message_box_scene.tscn")

const ANIMATIONS = {
	TYPE = 'typing',
}

func _ready():
	contacts_screen.show()
	message_screen.hide()
	write_clicked = false
	can_send = false
	can_dive = false
	
func _on_submerge_button_pressed():
#	if !can_dive: return
	
	SceneLoader.scene_transition(Globals.SCENES.SUBMERGE)


func _on_write_button_pressed():
	if write_clicked: return
	
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
		can_send = true
		


func _on_send_button_pressed():
	if !can_send: return
	
	can_dive = true


func _on_contact_1_button_pressed():
	contacts_screen.hide()
	current_contact = Globals.CHARACTERS.DAUGHTER
	message_screen.show()


func _on_contact_2_button_pressed():
	contacts_screen.hide()
	message_screen.show()


func _on_contacts_button_pressed():
	contacts_screen.show()
	message_screen.hide()
