extends CharacterBody2D

signal health_changed(old_health: float, new_health: float)

@onready var weapon: Sprite2D = $Weapon


var health := 0.0
var speed := 400
var weapon_distance := 100.0

# Called when the node enters the scene tree for the first time.
func _ready():
	health = 100.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_align_weapon(delta)


func _physics_process(delta: float) -> void:
	var input := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	self.velocity = input * speed
	move_and_slide()
	
	
func _align_weapon(delta: float) -> void:
	var target_angle := self._target_selection()
	if target_angle < 0.0:
		target_angle += 2 * PI
	if target_angle >= PI / 2 and target_angle <= 3 * PI / 2:
		weapon.flip_v = true
	else:
		weapon.flip_v = false
	weapon.rotation = target_angle
	
	var weapon_shift := Vector2.RIGHT.rotated(weapon.rotation) * weapon_distance
	weapon.global_position = self.position + weapon_shift


func _target_selection() -> float:
	var level := get_parent()
	var enemy_positions: Array = []
	for child in level.get_children():
		if child.is_in_group('enemy'):
			enemy_positions.append(child.position)
	
	if len(enemy_positions) == 0:
		return 0.0

	var smallest_distance := self.position.distance_to(enemy_positions[0])
	var target_angle := self.get_angle_to(enemy_positions[0])
	
	for enemy_position in enemy_positions:
		var distance := self.position.distance_to(enemy_position)
		if distance < smallest_distance:
			smallest_distance = distance
			target_angle = self.get_angle_to(enemy_position)
	return target_angle


func take_damage(damage: float) -> void:
	var new_health := health - damage
	health = new_health
	health_changed.emit(health, new_health)
	
