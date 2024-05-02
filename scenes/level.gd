class_name level extends Node2D

@onready var player := $Player
@onready var gui := $GUI
@onready var timer: Timer = $Timer
@onready var enemy_spawner: Node = $EnemySpawner

## Level size of X coordinates. Example: [-400, 400]
@export var x_range: Array[int]
## Level size of y coordinates. Example: [-400, 400]
@export var y_range: Array[int]

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(x_range != [] or y_range != [], "level size must be set")
	player.health_changed.connect(_on_health_changed)
	timer.timeout.connect(_on_timer_expired)
	enemy_spawner.set_level_size(x_range, y_range)


func _process(delta: float) -> void:
	gui.set_time(round(timer.time_left))
  

func _on_health_changed(old_health: float, new_health: float) -> void:
	gui.set_health(new_health)
	
	if new_health <= 0:
		_end_game()


func _end_game() -> void:
	var main_menu: Node = load("res://scenes/main_menu.tscn").instantiate()
	add_sibling(main_menu)
	queue_free()


func _on_timer_expired() -> void:
	_end_game()
