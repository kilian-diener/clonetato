extends CharacterBody2D


var damage: float
var direction: float
var speed: float

func shoot(speed: float, damage: float, direction: float) -> void:
	assert(speed != 0.0, "bullet needs a speed")
	self.speed = speed
	self.damage = damage
	self.direction = direction


func _physics_process(delta: float) -> void:
	var collision := move_and_collide(Vector2.from_angle(direction) * speed * delta)
	if collision:
		if collision.get_collider().has_method('take_damage'):
			collision.get_collider().take_damage(damage)
		queue_free()
