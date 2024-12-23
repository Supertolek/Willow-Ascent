extends Control

func resize():
	$Level.position = get_viewport_rect().size/2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resize()
	get_tree().get_root().size_changed.connect(resize)


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/platformer.tscn")

func _on_multiplayer_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/multiplayer_menu.tscn")

func _on_settings_button_pressed() -> void:
	$HomeScreenMenu.visible = false
	$PanelContainer.visible = true


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_back_button_pressed() -> void:
	$PanelContainer.visible = false
	$HomeScreenMenu.visible = true


#func _on_username_input_text_changed(new_text: String) -> void:
	#if len(new_text) >= 3 and len(new_text) <= 16 and not " " in new_text:
		#Global.username = new_text
