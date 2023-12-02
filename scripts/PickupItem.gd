extends AnimatableBody2D


var is_held: bool = false
@onready var player = get_node("../Player")
@onready var itemAnchor = get_node("../Player/ItemHolder/ItemAnchor")

func _physics_process(_delta):
	if is_held == true:
		#print("is holding!")
		self.position = itemAnchor.global_position

func _input(_event):
	if Input.is_action_just_pressed("pickup_item"):
		#print("pickup item")
		var bodies = $Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player" and player.canHold == true:
				is_held = true
				player.canHold = false
				
	if Input.is_action_just_pressed("drop_item") and is_held == true:
		#print("drop item")
		is_held = false
		player.canHold = true
