@tool
class_name LobbyPlayer
extends HBoxContainer

@export var username: String:
	get:
		return username
	set(value):
		username = value
		username_label.text = value

@export var id: int
	

var username_label = Label.new()
var kick_button = LinkButton.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	username_label.text = username
	kick_button.text = "kick"
	add_child(username_label)
	add_child(kick_button)

func _kick_button_pressed():
	if id in Global.player_list:
		multiplayer.multiplayer_peer.disconnect_peer(id)
