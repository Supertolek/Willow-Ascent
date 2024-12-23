extends Control

func resize():
	$Level.position = get_viewport_rect().size/2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resize()
	get_tree().get_root().size_changed.connect(resize)

func check_ip_adress(ip_adress: String) -> Array:
	var ip_adress_content: String
	var port: int = 65530
	var is_port_valid: bool = true
	if ip_adress.contains(":"):
		# A port is given
		var ip_adress_content_splited := ip_adress.split(":")
		print(ip_adress_content_splited)
		ip_adress_content = ip_adress_content_splited[0]
		if ip_adress_content_splited[1].is_valid_int():
			# The port given is valid
			port = ip_adress_content_splited[1].to_int()
			if port < 0 or port > 65535:
				# Port is within valid port
				is_port_valid = false
		else:
			is_port_valid = false
	else:
		ip_adress_content = ip_adress
	return [is_port_valid and ip_adress_content.is_valid_ip_address(), ip_adress_content, port]

# Join options
func connect_to_server(ip_adress: String, port: int, success_callback: Callable, fail_callback) -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ip_adress, port)
	multiplayer.multiplayer_peer = peer
	multiplayer.connected_to_server.connect(success_callback)
	multiplayer.connection_failed.connect(fail_callback)

func _on_join_ip_adress_text_changed(new_text: String) -> void:
	%JoinButton.disabled = not check_ip_adress(new_text)[0]

func successful_connection() -> void:
	print("Connected to server")
	Global.is_multiplayer = true
	Global.multiplayer_mode = false
	get_tree().change_scene_to_file("res://scenes/lobby.tscn")

func failed_connection() -> void:
	print("Unable to connect")

func _on_join_button_pressed() -> void:
	var ip_adress_unfolded = check_ip_adress(%JoinIPAdress.text)
	print(ip_adress_unfolded)
	if ip_adress_unfolded[0]:
		Global.multiplayer_ip_adress = ip_adress_unfolded[1]
		Global.multiplayer_port = ip_adress_unfolded[2]
		connect_to_server(ip_adress_unfolded[1], ip_adress_unfolded[2], successful_connection, failed_connection)

# Server options

func _on_host_button_pressed() -> void:
	Global.multiplayer_port = %HostPort.value
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(%HostPort.value)
	multiplayer.multiplayer_peer = peer
	Global.is_multiplayer = true
	Global.multiplayer_server = true
	get_tree().change_scene_to_file("res://scenes/lobby.tscn")

# Other options

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/home_screen.tscn")
