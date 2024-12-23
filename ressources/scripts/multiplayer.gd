


var is_multiplayer: bool = false
var is_server: bool = false
var players: Dictionnary[OnlinePlayer]

# Server-side functions
@rpc("all-peers")
func server_accept_player(username: String):
    var id = ???
    var player = OnlinePlayer.new()
    player.id = id
    player.username = username
    players[id] = player

@rpc("all-peers")
func server_update_player_data():
    pass

@rpc("all-peers")
func server_receive_message(message: String):
    receive_message(id, message)

@rpc("all-peers")
func server_receive_command(command_name: String, arguments: Array):
    pass

func server_kick_player(id: int):
    pass

func start_game():
    pass

# client-side functions
@rpc
func player_joined(player_object: OnlinePlayer):
    players[player_object.id] = player_object

@rpc
func player_left(id: int):
    players -= id

@rpc
func player_data_updated(player_object: OnlinePlayer):
    players[player_object.id] = player_object

@rpc
func game_started():
    pass

@rpc
func receive_message(sender_id: int, message: String):
    pass

func send_join_request()
func send_leave_request
func update_data
func send_message
func send_command