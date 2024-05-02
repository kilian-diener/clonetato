extends CanvasLayer

var health := 0.0

@onready var health_bar: ProgressBar = $HealthBar
@onready var countdown: Label = $Countdown

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_health(100.0)


func set_health(new_health: float) -> void:
	health = new_health
	health_bar.value = new_health


func set_time(time: int) -> void:
	countdown.text = str(time)
