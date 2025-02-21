extends Area2D
## Handles logic for structural walls and (hopefully) towers


var sprite
var collision
var image

@export var is_dragging = false
@export var can_build = false

# dictionary of arrays to hold values for Sprite2D and CollisionShape2D
# "name of piece": ["path to sprite resource", width(px), height(px), y offset] 
@export var stuctures_dict = {
	"wall_s": ["res://assets/Wall Small Asset.png", 32, 46, 1],
	"wall_m": ["res://assets/Wall Medium Asset.png", 64, 46, 1],
	"wall_l": ["res://assets/Wall Large Asset.png", 96, 46 , 1],
	"tower_s": ["res://assets/Tower Small Asset.png", 48, 104, 4],
	"tower_l": ["res://assets/Tower Tall Asset.png", 62, 135, 4.5]
}

# holds extracted structures_dict array
var structure_values = []


# Called when the node enters the scene tree for the first time. The id of the
# piece is passed when the node is created. Defaults to small wall.
func _ready(id := "wall_s"):
	sprite = $Sprite2D
	collision = $CollisionShape2D
	structure_values = stuctures_dict[id]
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
		
		
