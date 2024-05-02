extends Sprite2D

@onready var timer: Timer = $Timer


var damage := 34
var rate_of_fire := 0.5
var speed := 700.0
var bullet_scene := load("res://scenes/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = rate_of_fire
	timer.timeout.connect(_shoot)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _shoot() -> void:
	var bullet: Node = bullet_scene.instantiate()
	owner.owner.add_child(bullet)
	bullet.position = $Muzzle.global_position
	bullet.rotation = self.rotation
	bullet.shoot(speed, damage, self.rotation)
