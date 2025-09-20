extends Node2D

@export var maxPlanetSize = 100
@export var minPlanetSize = 50

@export var minPlanets = 1
@export var maxPlanets = 1

@export var minFreeSpace = 40

@export var gravityMultiplier = 600

var planets: Array[Dictionary] = []
var spawn_area: Rect2

func _draw() -> void:
	for planet_data in planets:
		var pos = planet_data.position
		var rad = planet_data.radius
		
		draw_circle(pos, rad, Color(randf(), randf(), randf(), 1))

func _ready() -> void:
	randomize()
	
	spawn_area = get_viewport_rect()
	for i in range(randi_range(minPlanets, maxPlanets)):
		var overlaps = true
		var new_radius: int
		var new_pos: Vector2
		
		while overlaps:
			overlaps = false
			new_radius = randi_range(minPlanetSize, maxPlanetSize)
			
			new_pos = Vector2(
				randi_range(spawn_area.position.x, spawn_area.end.x ),
				randi_range(spawn_area.position.y, spawn_area.end.y)
			)
			
			for existing_planet in planets:
				var existing_pos = existing_planet.position
				var existing_radius = existing_planet.radius
				
				var min_distance = new_radius + existing_radius + minFreeSpace
		
				if new_pos.distance_squared_to(existing_pos) < min_distance * min_distance:
					overlaps = true
					break
					
		planets.append({"position": new_pos, "radius": new_radius, "mass": (new_radius^2)*PI})
		
	for planet_data in planets:
		var pos = planet_data.position
		var rad = planet_data.radius
		var mass = planet_data.mass
		
		var physics_body = StaticBody2D.new()
		add_child(physics_body)
		physics_body.global_position = pos
		
		var collision_shape = CollisionShape2D.new()
		physics_body.add_child(collision_shape)
		collision_shape.shape = CircleShape2D.new()
		collision_shape.shape.radius = rad
		
		var gravity_area = Area2D.new()
		physics_body.add_child(gravity_area)
		
		gravity_area.gravity_point = true
		gravity_area.gravity_point_center = Vector2.ZERO
		gravity_area.gravity = mass * gravityMultiplier
		gravity_area.SPACE_OVERRIDE_REPLACE
			
		var gravity_range_shape = CollisionShape2D.new()
		gravity_range_shape.shape = CircleShape2D.new()
		gravity_range_shape.shape.radius = rad * 2.0 
		gravity_area.add_child(gravity_range_shape)
		
		
	queue_redraw()
