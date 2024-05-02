extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	var main_menu: Node = load("res://scenes/main_menu.tscn").instantiate()
	add_child(main_menu)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
