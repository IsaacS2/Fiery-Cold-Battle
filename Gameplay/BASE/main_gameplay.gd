extends Node2D
class_name MainGameplayNode2D

signal on_root_ready()


var player: PlayerCharacter2D
var player_spawn_point: Node2D

var enemy_count: int

func accept_player_death() -> void:
	_handle_player_death()

func accept_enemy_death() -> void:
	_handle_enemy_death()

func _ready() -> void:
	_init_game()
	on_root_ready.emit()

func _init_game() -> void:
	player = get_tree().get_first_node_in_group(Groups.player_character)
	player_spawn_point = get_tree().get_first_node_in_group(Groups.player_spawn)
	enemy_count = get_tree().get_nodes_in_group(Groups.enemy_character).size()
	player.global_position = player_spawn_point.global_position

func _handle_player_death() -> void:
	AutoloadLifeTracker._delete_life()
	if AutoloadLifeTracker.current_life_count > 0:
		_respawn_player()
	else:
		_run_game_over()

func _handle_enemy_death() -> void:
	enemy_count -= 1
	if enemy_count < 1:
		_run_next_round()

func _respawn_player() -> void:
	player.global_position = player_spawn_point.global_position

func _run_game_over() -> void:
	get_tree().paused = true
	print("Game Over")

func _run_next_round() -> void:
	pass
