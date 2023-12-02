extends AnimatableBody2D


var is_held: bool = false
@onready var itemAnchor = get_node("../Player/ItemHolder/ItemAnchor")


func _physics_process(_delta):
	if is_held == true:
		print("is holding!")
		self.position = itemAnchor.global_position
