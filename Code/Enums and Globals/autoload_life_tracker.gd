extends Node

const STARTING_LIVES: int = 3
var current_life_count: int

func _ready() -> void:
	_init_lives()

func _init_lives() -> void:
	current_life_count = STARTING_LIVES

func _delete_life() -> void:
	current_life_count -= 1
