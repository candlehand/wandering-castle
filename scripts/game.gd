extends Node
## Handles main game screen functionality

# importing scenes to be used in script
var structure = preload("res://scenes/structure.tscn")
var physics_structure = preload("res://scenes/physics_structure.tscn")
var player_castle

var player_health = 40
var enemy_health = 40
var walking = false

var structure_name
var new_structure

var placing_piece = false
var desired_x
var desired_y

# determines forward speed of castle
var castle_velocity = .5
signal is_dragging
signal structure_hit


# Called when the node enters the scene tree for the first time.
func _ready():
	# assign nodes
	player_castle = $Castle
	$Castle/AnimatedSprite2D.pause()
	# inits the random number generator
	randomize()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.running == true:
		walking = true
	if player_health <= 0:
		walking = false
		$Castle/AnimatedSprite2D.pause()
		print("Game over!!!")
		# load the death message
		var image = Image.load_from_file("res://assets/Game_Over.png")
		$YouDied/Sprite2D.texture = ImageTexture.create_from_image(image)
	if enemy_health <= 0:
		# winning happens
		print("You win!")
		Global.running = false
		pass
	if Global.running == false:
		walking = false
	if $Castle.position.x > 750:
		walking = false
		$Castle/AnimatedSprite2D.pause()
	if walking == true:
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
			var desired_x = (floor(cursor_position.x / 8) * 8) + 5
			var desired_y = floor(cursor_position.y / 8) * 8
			new_structure.position = Vector2(desired_x, desired_y)
			# detect mouse clicks from the player and try placing the item
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and placing_piece:
				var cursor_position = player_castle.get_local_mouse_position()
				var desired_x = (floor(cursor_position.x / 8) * 8) + 5
				var desired_y = floor(cursor_position.y / 8) * 8
				print(new_structure)
				new_structure.queue_free()
				placing_piece = false
				create_physics_structure(structure_name, desired_x, desired_y)
				print("Left button was clicked at ", event.position)


# called when a build button is pressed
func _on_build_control_create_structure(dict_key):
	# calls constructor method in Structure, passes key from button
	print("The castle hears the button's call.")
	structure_name = dict_key
	if structure_name == "cannon":
		var cannon_scene: PackedScene = load("res://scenes/cannon.tscn")
		new_structure = cannon_scene.instantiate()
		player_castle.add_child(new_structure)
	else:
		new_structure = Structure.new_structure(structure_name)
		# set is_dragging for game & structure scenes
		is_dragging.emit(true)
		player_castle.add_child(new_structure)
	placing_piece = true


# takes the structure_name as argument to generate a RigidBody2D version of the structure
func create_physics_structure(structure_name, x, y):
	print("Structure name: ", structure_name)
	if structure_name == "cannon":
		# make a cannon or catapult!
		print(structure_name, " Brought us into the cannon code")
		var cannon_scene: PackedScene = load("res://scenes/cannon_rigid.tscn")
		var rigid_cannon = cannon_scene.instantiate()
		rigid_cannon.connect("keep_hit", _on_cannonball_keep_hit)
		rigid_cannon.connect("structure_hit", _on_cannonball_structure_hit)
		player_castle.add_child(rigid_cannon)
		rigid_cannon.position = Vector2(x, y)
	else:
		# make a regular structure!
		print("Generating physics structure: ", structure_name)
		new_structure = PhysicsStructure.new_structure(structure_name)
		new_structure.construct(structure_name)
		player_castle.add_child(new_structure)
		new_structure.position = Vector2(x, y)


func _on_build_control_go_forth():
	walking = true
	$Castle/AnimatedSprite2D.play()
	pass


func _on_cannonball_keep_hit(body):
	if body.is_in_group("player"):
		player_health -= 1
	if body.is_in_group("enemy"):
		enemy_health -= 1

func _on_cannonball_structure_hit(body):
	body.health -= 1
	pass
	
