extends CharacterBody2D


@onready var pickupItem = get_node("../PickupItem")

@export var speed: float = 50000.0
@export var accel: float = 50000.0

var canHold = true


func _physics_process(delta):
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = direction.normalized() * delta * speed
	move_and_slide()

func _input(_event):
	if Input.is_action_just_pressed("pickup_item"):
		var bodies = $Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.name == "PickupItem" and self.canHold == true:
				print("pickup item")
				pickupItem.is_held = true
				self.canHold = false
				
	if Input.is_action_just_pressed("drop_item") and pickupItem.is_held == true:
		#print("drop item")
		pickupItem.is_held = false
		self.canHold = true
