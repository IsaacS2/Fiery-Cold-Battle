extends Area2D
class_name Grabber2D

var ring: ProjectileRing

func _ready() -> void:
	var children: Array = get_children()
	for child in children:
		if child is ProjectileRing:
			ring = child
			return

func check_projectiles() -> void:
	print("Checking projectiles")
	var overlapping_bodies = get_overlapping_bodies()
	for body in overlapping_bodies:
		if body is Projectile2D:
			print("Projectile checked")
			ring.attempt_capture_projectile(body)

func fire_projectiles() -> void:
	ring.fire_projectiles()
