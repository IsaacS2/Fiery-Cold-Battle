extends Node
class_name ProjectilePool

const PROJECTILE = preload("res://Gameplay/BASE/projectile_2d.tscn")
const POOL_SIZE: int = 20

var pool: Array = []

func _ready() -> void:
	for i in range(POOL_SIZE):
		var projectile = PROJECTILE.instantiate() as Projectile2D
		projectile.deactivate()
		pool.append(projectile)
		add_child(projectile)

func get_projectile() -> Projectile2D:
	for projectile in pool:
		if not projectile.visible:
			return projectile
	return null

func return_projectile(projectile: Projectile2D):
	projectile.deactivate
	
