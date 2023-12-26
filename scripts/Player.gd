extends CharacterBody2D


@onready var pickupItem = get_node("../PickupItem")
@onready var hand = $ItemHolder/ItemAnchor
@onready var pickup_raycast = $ItemHolder/PickupRaycast

@export var speed: float = 50000.0
@export var accel: float = 50000.0

@export var use_controller: bool = false

var picked_object
var pull_power: int = 100


func _physics_process(delta):
	#movement
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = direction.normalized() * delta * speed
	move_and_slide()
	
	#aiming
	var aim_direction: Vector2 = Vector2.ZERO
	
	if use_controller:
		aim_direction = Vector2(
			Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left"),
			Input.get_action_strength("aim_down") - Input.get_action_strength("aim_up")
		)
	else:
		aim_direction = get_global_mouse_position() - global_position
	if aim_direction.length_squared() > 0.5:
		rotation = aim_direction.angle()
	
	
	
	
	if picked_object!= null:
		var a = picked_object.global_transform.origin
		var b = hand.global_transform.origin
		
		picked_object.set_linear_velocity((b-a) * pull_power)
		picked_object.rotation = self.rotation


func _input(event: InputEvent) -> void:
	#toggles between mosue input and controller input depending on what input is being used
	if use_controller and event is InputEventMouseMotion or event is InputEventKey:
		use_controller = false
	elif not use_controller and event is InputEventJoypadButton or event is InputEventJoypadMotion:
		use_controller = true
	
	
	if event.is_action_pressed("grab"):
			if picked_object == null:
				pick_object()
			elif picked_object != null:
				remove_object()


func pick_object():
	var object = pickup_raycast.get_collider()
	
	if object != null and object.is_in_group("Item"):
		picked_object = object
		$"../UI/ControllerUI/VBoxContainer/Grab".hide()
		$"../UI/ControllerUI/VBoxContainer/Drop".show()
		$"../UI/Keyboard&MouseUI/VBoxContainer/Grab".hide()
		$"../UI/Keyboard&MouseUI/VBoxContainer/Drop".show()

func remove_object():
	if picked_object != null:
		picked_object = null
		$"../UI/ControllerUI/VBoxContainer/Grab".show()
		$"../UI/ControllerUI/VBoxContainer/Drop".hide()
		$"../UI/Keyboard&MouseUI/VBoxContainer/Grab".show()
		$"../UI/Keyboard&MouseUI/VBoxContainer/Drop".hide()
