extends CharacterBody2D

signal enemy_destroyed

@onready var area_2d: Area2D = $Area2D
@onready var health_bar = $HealthBar

var health := 0.0
var damage := 40.0
var speed := 250.0

# Called when the node enters the scene tree for the first time.
func _ready():
	area_2d.body_entered.connect(_on_body_entered)
	_set_health(100)


func _physics_process(delta: float) -> void:
	var player_position := _target_player()
	var movement := player_position * speed * delta
	var collision = move_and_collide(movement)


func take_damage(damage: float) -> void:
	var new_health := health - damage
	if new_health <= 0:
		queue_free()
		enemy_destroyed.emit()
	_set_health(new_health)
	

func _set_health(new_health: float) -> void:
	health = new_health
	health_bar.value = new_health


func _on_body_entered(body_that_entered: Node2D):
	if body_that_entered.has_method('take_damage'):
		body_that_entered.take_damage(damage)


func _target_player() -> Vector2:
	var player: CharacterBody2D = get_parent().get_node("Player")
	var angle_to_player := self.get_angle_to(player.position)
	return Vector2.from_angle(angle_to_player)

