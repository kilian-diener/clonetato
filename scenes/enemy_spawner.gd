extends Node

@onready var timer: Timer = $Timer

var enemy_scene := preload("res://scenes/enemy.tscn")
var x_range: Array[int]
var y_range: Array[int]
var border_margin := 100
var player_margin := 300.0
var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(_on_timer_expired)
	player = get_parent().get_node("Player")


func _on_timer_expired() -> void:
	var position := _get_random_position()
	var enemy = enemy_scene.instantiate()
	enemy.position = position
	get_parent().add_child(enemy)


func _get_random_position() -> Vector2:
	var x_position := randf_range(x_range[0] + border_margin, x_range[1] - border_margin)
	var y_position := randf_range(y_range[0] + border_margin, y_range[1] - border_margin)
	var random_position := Vector2(x_position, y_position)

	if random_position.distance_to(player.position) > player_margin:
		return random_position
	else:
		return _get_random_position()


func set_level_size(x_range: Array[int], y_range: Array[int]) -> void:
	self.x_range = x_range
	self.y_range = y_range
