extends Node

enum Direction{
	NONE,
	UP,
	RIGHT,
	DOWN,
	LEFT
}

func direction_to_value_horizontal(direction: Direction) -> int:
	if direction == Direction.RIGHT:
		return 1
	elif direction == Direction.LEFT:
		return -1
	else:
		return 0
