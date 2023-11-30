extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#toggle UI mode
	if get_node("../Player/ItemHolder").use_controller == true:
		$ControllerUI.show()
		$"Keyboard&MouseUI".hide()
	else:
		$ControllerUI.hide()
		$"Keyboard&MouseUI".show()
