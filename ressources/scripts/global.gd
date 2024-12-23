extends Node

var username: String = "Player"
var is_multiplayer: bool = false
var multiplayer_server: bool = false
var multiplayer_ip_adress: String
var multiplayer_port: int
var player_list: Dictionary
# {id: {username}}
