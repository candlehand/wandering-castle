extends Control


var castle = preload("res://scenes/castle.tscn")
var structure = preload("res://scenes/structure.tscn")
var structures_dict
var dict_values
var dict_key

var rand_icon = ["wall_s", "wall_m", "wall_l", "tower_s", "tower_l"]
var rand_choice = 0

var button
var image
var new_piece
var new_icon

signal create_structure


# Called when the node enters the scene tree for the first time.
func _ready():
	structures_dict = Global.structures_dict
	generate_menu()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# 'i' denotes the number of the button starting from left; 0, 1, 2, 3
func _on_press(dict_key):
	create_structure.emit(dict_key)
	print("The ", dict_key," button calls for aid!")

# generate the buttons dynamically, with randomization
func generate_menu():
	var hbox = $HBoxContainer
	for i in range(0, 4):
		# generate random number 0-4
		rand_choice = randi() % 5
		# use that number to assign a dict key value from the rand_icon table
		dict_key = rand_icon[rand_choice]
		# assign the found dict values to a variable
		dict_values = structures_dict[dict_key]
		button = Button.new()
		# bind the buttons to the on-click method, pass i as identifier
		button.pressed.connect(_on_press.bind(dict_key))
		image = Image.load_from_file(dict_values[0])
		new_icon = create_icon(image)
		button.icon = ImageTexture.create_from_image(image)
		hbox.add_child(button)

# shrinks the image by a factor of 2 to create smaller icons from assets
func create_icon(image: Image):
	var height = image.get_height()
	var width = image.get_width()
	height /= 2
	width /= 2
	image.resize(width, height, 1)
	return image
	pass
