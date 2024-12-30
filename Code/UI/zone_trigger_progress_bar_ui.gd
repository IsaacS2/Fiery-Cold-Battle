extends ProgressBar
class_name ZoneTriggerProgressBarUI

# temp colors for placeholder texture element
# remove after replacing with icons
const COLOR_RED: Color = Color(1, 0, 0, 0.75)
const COLOR_BLUE: Color = Color(0, 0, 1, 0.75)

var player: PlayerCharacter2D
var ui_icon: TextureRect

func _on_main_gameplay_on_root_ready() -> void:
	ui_icon = get_parent().get_node("TextureRect")
	player = get_tree().get_first_node_in_group(Groups.player_character)
	if player:
		max_value = player.ZONE_TRIGGER_DELAY

func _process(delta: float) -> void:
	_progress_bar_logic()

func _progress_bar_logic() -> void:
	if not player:
		return
	value = player.zone_trigger_countup
	
	# replace this logic with something that swaps sprite textures
	if player.current_element == Common.Elements.FIRE and ui_icon and not ui_icon.self_modulate == COLOR_RED:
		ui_icon.self_modulate = COLOR_RED
	elif player.current_element == Common.Elements.ICE and ui_icon and not ui_icon.self_modulate == COLOR_BLUE:
		ui_icon.self_modulate = COLOR_BLUE
