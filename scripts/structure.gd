extends Area2D
class_name Structure
## Handles logic for structural walls and (hopefully) towers

var health = 10
var sprite
var collision
var image

@export var is_dragging = false
@export var can_build = false

# dictionary of arrays to hold values for Sprite2D and CollisionShape2D
# "name of piece": ["path to sprite resource", width(px), height(px), y offset] 
var structures_dict

var key : String = "wall_s"

# holds extracted structures_dict array
var structure_values = []


# Called when the node enters the scene tree for the first time. The id of the
# piece is passed when the node is created. In emergencies, defaults to small wall.
func _ready(id := key):
	structures_dict = Global.structures_dict
	# connect to menu button signal
	$"../BuildControl"
	# when created, generate the wall programmically
	sprite = $Sprite2D
	collision = $CollisionShape2D
	structure_values = structures_dict[id]
	# set the sprite
	image = Image.load_from_file(structure_values[0])
	sprite.texture = ImageTexture.create_from_image(image)
	# a funny little exception for tower_s
	if id == "tower_s":
		sprite.position.y = structure_values[4]
	# set the collision box size and position
	collision.shape.size = Vector2(structure_values[1], structure_values[2])
	collision.position.y = structure_values[3]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health <= 0:
		self.queue_free()
		pass


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



