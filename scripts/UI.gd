extends CanvasLayer

@onready var player = get_node("../Player/ItemHolder")

func _process(_delta):
	#toggle UI mode
	if player.use_controller == true:
		$ControllerUI.show()
		$"Keyboard&MouseUI".hide()
	else:
		$ControllerUI.hide()
		$"Keyboard&MouseUI".show()
