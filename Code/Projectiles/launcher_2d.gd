extends StaticBody2D
class_name Launcher2D

const FIRE_DELAY: float = 4.0
const OFFSET: Vector2 = Vector2(-10, 0)

var fire_countdown: float = 0.0
var pool: ProjectilePool

func _ready() -> void:
	pool = get_tree().get_first_node_in_group(Groups.projectile_pool)
	fire_countdown = FIRE_DELAY
	set_physics_process(true)

func _physics_process(delta: float) -> void:
	fire_countdown -= delta
	#print(fire_countdown)
	if fire_countdown < 0:
		fire_countdown = FIRE_DELAY
		_fire_projectile()

func _fire_projectile() -> void:
	var projectile = pool.get_projectile()
	print(projectile)
	if projectile:
		projectile.global_position = global_position + OFFSET
		projectile.activate()
		projectile.set_path()
