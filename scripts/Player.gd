extends CharacterBody2D

@export var max_health: int = 3
@export var speed: float = 50000.0
@export var accel: float = 50000.0

var canHold = true


func _physics_process(delta):
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = direction.normalized() * delta * speed
	move_and_slide()
