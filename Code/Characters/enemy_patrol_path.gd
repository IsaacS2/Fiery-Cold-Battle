extends Area2D
class_name EnemyPatrolPath

var my_col: CollisionShape2D

func _ready() -> void:
	var children: Array = get_children()
	for child in children:
		if child is CollisionShape2D:
			my_col = child
			break
	var bodies: Array = get_overlapping_bodies()
	print(bodies)
	for body in bodies:
		if body is EnemyBody2D:
			body.accept_patrol_path(self, my_col)
	var areas: Array = get_overlapping_areas()
	print(areas)

func _on_body_entered(body: Node2D) -> void:
	if body is EnemyBody2D:
		body.accept_patrol_path(self, my_col)
