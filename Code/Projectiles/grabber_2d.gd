extends Area2D
class_name Grabber2D

var ring: ProjectileRing

var currently_grabbing:bool = false

func _ready() -> void:
	var children: Array = get_children()
	for child in children:
		if child is ProjectileRing:
			ring = child
			return

func start_grabbing() -> void:
	currently_grabbing = true
	SoundManager.play_absorb_on()

func check_projectiles() -> void:
	var overlapping_bodies = get_overlapping_bodies()
	for body in overlapping_bodies:
		if body is Projectile2D:
			ring.attempt_capture_projectile(body)

func fire_projectiles() -> void:
	currently_grabbing = false
	SoundManager.stop_absorb_on()
	ring.fire_projectiles()

func _physics_process(delta: float) -> void:
	if currently_grabbing:
		check_projectiles()
