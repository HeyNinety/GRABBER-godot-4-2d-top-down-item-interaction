extends RigidBody2D


var is_held = false

func _physics_process(_delta):
	if is_held == true:
		#print("is holding!")
		self.position = get_node("../Player/ItemHolder/ItemAnchor").global_position

func _input(_event):
	if Input.is_action_just_pressed("pickup_item"):
		#print("pickup item")
		var bodies = $Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player" and get_node("../Player").canHold == true:
				is_held = true
				get_node("../Player").canHold = false
				
	if Input.is_action_just_pressed("drop_item") and is_held == true:
		#print("drop item")
		is_held = false
		get_node("../Player").canHold = true
