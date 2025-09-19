extends Node2D
var wing_route = preload("res://Boss/wing/wing_route.tscn")


func _ready() -> void:

	for wing in get_children():
		var wingscene = wing_route.instantiate()
		#set the wing to see if it is right or left of the main eye and transform as needed
		rightorleftofeye(wing)
		print(wing)
		#adds in a wing at each of the point
		wing.add_child(wingscene)
		pass
	pass
	
	
func rightorleftofeye(point):
	#inverts the thing depending on what side the wing is on
	if point.position.x >= 0:
		point.scale.x*=-1
		pass
	pass
