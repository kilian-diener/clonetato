extends Node

@onready var start_button = $StartButton



# Called when the node enters the scene tree for the first time.
func _ready():
	start_button.pressed.connect(_start_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _start_button_pressed() -> void:
	var loaded_level: Node = load("res://scenes/level.tscn").instantiate()
	add_sibling(loaded_level)
	queue_free()
