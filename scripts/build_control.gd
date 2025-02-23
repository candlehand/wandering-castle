extends Control
## BuildControl script
## holds & creates player interactable buttons


# variables for accessing the global structure dictionary
var structures_dict
var dict_values
var dict_key
var struct_names = ["wall_s", "wall_m", "wall_l",
					"tower_s", "tower_m", "tower_l",
					"cannon", "catapult"]
# holds values for iterization and randomization
var struct_iter
var rand_choice = 0

# holds values relating to buttons and their icons
var button
var image
var new_piece
var new_icon

signal go_forth
signal create_structure
signal create_cannon


# Called when the node enters the scene tree for the first time.
func _ready():
	# access the global structure values
	structures_dict = Global.structures_dict
	generate_menu()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# 'i' denotes the number of the button starting from left; 0, 1, 2, 3
func _on_press(dict_key):
	print("[SIGNAL] The ", dict_key," button calls for aid!")
	create_structure.emit(dict_key)


# generate the buttons dynamically
func generate_menu():
	var walls = $WallsContainer
	var towers = $TowerContainer
	var booms = $BoomContainer
	# iterate through the buttons, populating them with images
	# 3 wall buttons, top row
	for i in range(0, 3):
		read_dict(i)
		button_creator(walls)
	# 3 towers, middle row
	for i in range(3, 6):
		read_dict(i)
		button_creator(towers)
	# weapons, bottom row
	read_dict(6)
	button_creator(booms)
	
func read_dict(i):
	# use i to iterate, selecting increasing value from dict
	struct_iter = i
	# use that number to assign a key value from the struct_name table
	dict_key = struct_names[struct_iter]
	# assign the found dict values to a variable
	dict_values = structures_dict[dict_key]

# creates a new button, accepts the button's container(parent) as argument
func button_creator(container):
	button = Button.new()
	# bind the buttons to the on-click method, pass dict key as identifier
	button.pressed.connect(_on_press.bind(dict_key))
	image = Image.load_from_file(dict_values[0])
	new_icon = create_icon(image)
	button.icon = ImageTexture.create_from_image(image)
	container.add_child(button)

# shrinks the image by a factor of 2 to create smaller icons from assets
func create_icon(image: Image):
	var height = image.get_height()
	var width = image.get_width()
	height /= 2
	width /= 2
	image.resize(width, height, 1)
	return image
	pass

# Start button
func _on_start_button_pressed():
	$".".visible = false
	Global.running = true
	go_forth.emit()
