extends CharacterBody2D

@export var max_health: int = 3
@export var speed: float = 100000.0
@export var accel: float = 100000.0

var canHold = true


func _process(delta):
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = velocity.move_toward(direction, accel) * delta * speed
	move_and_slide()
