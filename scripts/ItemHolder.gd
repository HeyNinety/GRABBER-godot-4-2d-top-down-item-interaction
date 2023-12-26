extends Node2D

@onready var item = get_node("../../PickupItem")
@export var use_controller := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#toggles between mosue input and controller input depending on what input is being used
func _unhandled_input(event: InputEvent) -> void:
	if use_controller and event is InputEventMouseMotion or event is InputEventKey:
		use_controller = false
	elif not use_controller and event is InputEventJoypadButton or event is InputEventJoypadMotion:
		use_controller = true

var has_been_called = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var aim_direction := Vector2.ZERO
	
	
	if use_controller:
		aim_direction = Vector2(
			Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left"),
			Input.get_action_strength("aim_down") - Input.get_action_strength("aim_up")
		)
	else:
		aim_direction = get_global_mouse_position() - global_position
	if aim_direction.length_squared() > 0.5:
		rotation = aim_direction.angle()
		
	#find angle and round to nearest 45 degree (implement angle snapping later)
#	var exact_angle = rad_to_deg(aim_direction.angle())
#	var rounded_angle = int(round(exact_angle/45)*45)
#	match rounded_angle:
#		0:
#			#print("Right")
#			pass
#		-45:
#			#print("Up Right")
#			pass
#		-90:
#			#print("Up")
#			pass
#		-135:
#			#print("Up Left")
#			pass
#		180, -180:
#			#print("Left")
#			pass
#		135:
#			#print("Down Left")
#			pass
#		90:
#			#print("Down")
#			pass
#		45:
#			#print("Down Right")
#			pass
	if get_node("../../PickupItem").is_held == true:
		#print("is grabbing!")
		if has_been_called == false:
			get_viewport().warp_mouse(item.position)
			has_been_called = true
			
	if get_node("../../PickupItem").is_held == false:
		#print("is not grabbing!")
		has_been_called = false
