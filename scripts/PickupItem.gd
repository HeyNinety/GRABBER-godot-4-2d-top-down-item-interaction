extends AnimatableBody2D

@onready var originalParent = get_node("..")
@onready var itemAnchor = get_node("../Player")


func _on_player_pick_up_item():
	pickup()


func _on_player_drop_item():
	drop()


func pickup():
	reparent(itemAnchor)


func drop():
	reparent(originalParent)
