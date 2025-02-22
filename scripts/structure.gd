extends Area2D
class_name Structure
## Handles logic for structural walls and (hopefully) towers


var sprite
var collision
var image

@export var is_dragging = false
@export var can_build = false

# dictionary of arrays to hold values for Sprite2D and CollisionShape2D
# "name of piece": ["path to sprite resource", width(px), height(px), y offset] 
const structures_dict = {
	"wall_s": ["res://assets/Sunset Castle/Wall Small Sunset.png", 32, 48, 0],
	"wall_m": ["res://assets/Sunset Castle/Wall Medium Sunset.png", 64, 48, 0],
	"wall_l": ["res://assets/Sunset Castle/Wall Large Sunset.png", 96, 48, 0],
	"tower_s": ["res://assets/Sunset Castle/Tower Medium Sunset.png", 48, 105, 3.5],
	"tower_l": ["res://assets/Sunset Castle/Tower Large Sunset.png", 64, 137, 7.5]
}

var key : String = "wall_s"

# holds extracted structures_dict array
var structure_values = []


# Called when the node enters the scene tree for the first time. The id of the
# piece is passed when the node is created. Defaults to small wall.
func _ready(id := key):
	# connect to menu button signal
	$"../BuildControl"
	# when created, generate the wall programmically
	sprite = $Sprite2D
	collision = $CollisionShape2D
	structure_values = structures_dict[id]
	# set the sprite
	image = Image.load_from_file(structure_values[0])
	sprite.texture = ImageTexture.create_from_image(image)
	# set the collision box size and position
	collision.shape.size = Vector2(structure_values[1], structure_values[2])
	collision.position.y = structure_values[3]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

# binds object placement to grid. the +5 on line 25 is because we wonky in here
func _input(event):
	if is_dragging and event is InputEventMouseMotion:
		var cursor_position = get_parent().get_local_mouse_position()
		var desired_x = (floor(cursor_position.x / 16) * 16) + 5
		var desired_y = floor(cursor_position.y / 16) * 16
		self.position = Vector2(desired_x, desired_y)
		

# constructor method for building new structures; accepts dictionary key as input
static func new_structure(dict_key: String):
	print("The structures ride out!")
	var my_scene: PackedScene = load("res://scenes/structure.tscn")
	var new_structure: Structure = my_scene.instantiate()
	new_structure.key = dict_key
	return new_structure
	

# boolean toggle for is_dragging
func drag_toggle(bool := false):
	if is_dragging:
		print("drag is off")
		is_dragging = false
	else:
		print("drag is on")
		is_dragging = true

# captures signal telling the structure we draggin'
func _on_game_is_dragging(bool := true):
	print("drag toggle received")
	drag_toggle(bool)
	
