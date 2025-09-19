extends Node2D
var wing_route = load("res://Boss/wing/wing_route.tscn")


func ready() -> void:
	var wing_points=get_children()

	for wing in wing_points:
		
		#set the wing to see if it is right or left of the main eye and transform as needed
		rightorleftofeye()
		
		#adds in a wing at each of the point
		
		
		pass
	pass
	
func rightorleftofeye():
	pass
