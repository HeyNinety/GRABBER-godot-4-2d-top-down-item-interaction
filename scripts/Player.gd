extends CharacterBody2D

#pickupItem will be stored in this var
#var pickupItem: Node2D = null

@export var speed: float = 50000.0
@export var accel: float = 50000.0

signal pick_up_item
signal drop_item


func _physics_process(delta):
	#movement
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction.normalized() * delta * speed
	move_and_slide()
	look_at(get_global_mouse_position())

func _input(_event):
	if Input.is_action_just_pressed("pickup_item"):
		var bodies = $Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.is_in_group("item") == true:
				#print("pickup item")
				pick_up_item.emit()


	if Input.is_action_just_pressed("drop_item"):
		drop_item.emit()


var use_controller: bool = false

#toggles between mosue input and controller input depending on what input is being used
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion or event is InputEventKey:
		#send use controller false signal
		pass
	elif event is InputEventJoypadButton or event is InputEventJoypadMotion:
		#send use controller true signal
		pass
