extends Node
## Handles main game screen functionality

# importing scenes to be used in script
var structure = preload("res://scenes/structure.tscn")
var player_castle 

var new_structure

signal is_dragging
var placing_piece = false

# determines forward speed of castle
var castle_velocity = .5

# Called when the node enters the scene tree for the first time.
func _ready():
	# assign nodes
	player_castle = $Castle
	# inits the random number generator
	randomize()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# slowly and steadily moves the castle forward
	$Castle.position.x += castle_velocity
	pass

# used to capture inputs from player
func _input(event):
	# if player is holding a piece...
	if placing_piece: 
		# lock the piece to a relative grid
		if event is InputEventMouseMotion:
			var cursor_position = player_castle.get_local_mouse_position()
			var desired_x = (floor(cursor_position.x / 16) * 16) + 5
			var desired_y = floor(cursor_position.y / 16) * 16
			new_structure.position = Vector2(desired_x, desired_y)
		# detect mouse clicks from the player and try placing the item
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and placing_piece:
				print("we made it!")
				placing_piece = false
				# if item is in legal area...
					# place it!
						
				print("Left button was clicked at ", event.position)
		
# called when a build button is pressed
func _on_build_control_create_structure(dict_key):
	# calls constructor method in Structure, passes key from button
	print("The castle hears the button's call.")
	new_structure = Structure.new_structure(dict_key)
	# set is_dragging for game & structure scenes
	is_dragging.emit(true)
	placing_piece = true
	player_castle.add_child(new_structure)
	
