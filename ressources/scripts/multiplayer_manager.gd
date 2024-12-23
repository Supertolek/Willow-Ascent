extends Control

var players: Dictionary = {}

func resize():
	$Level.position = get_viewport_rect().size/2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resize()
	get_tree().get_root().size_changed.connect(resize)
	if Global.multiplayer_server:
		%MultiplayerLobbyTitle.text = "Multiplayer (host)"
	else:
		%MultiplayerLobbyTitle.text = "Multiplayer (guest)"
	multiplayer.peer_connected.connect(player_joined)

func remove_player(id: int) -> void:
	print(id)
	pass

@rpc
func add_player(id: int, username: String = "unknown") -> void:
	var player_container = HBoxContainer.new()
	var player_username = Label.new()
	player_username.text = username
	player_container.add_child(player_username)
	var player_kick = LinkButton.new()
	player_kick.text = "kick"
	player_kick.pressed.connect(remove_player, [id])
	player_container.add_child(player_kick)
	%Players.add_child(player_container)

func player_joined(id: int):
	add_player(id)

@rpc("any_peer")
func quit_server_by_force_this_is_not_an_exploit_at_alld():
	get_tree().quit()
