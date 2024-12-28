extends Control
class_name MainMenu

func _on_main_gameplay_on_root_ready() -> void:
	_open_menu()

func _open_menu() -> void:
	var first_button = get_tree().get_first_node_in_group(Groups.main_menu_buttons)
	first_button.grab_focus()

func _on_play_button_pressed() -> void:
	pass # Replace with function body.

func _on_options_button_pressed() -> void:
	pass # Replace with function body.

func _on_quit_button_pressed() -> void:
	get_tree().quit()
