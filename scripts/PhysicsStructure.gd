extends RigidBody2D
class_name PhysicsStructure
## version of structures item class that can be affected by physics

var sprite
var collision
var image

var cannonball = preload("res://scenes/cannonball.tscn")

var structures_dict
var structure_values = []
var key : String = "wall_s"

# Called when the node enters the scene tree for the first time.
func _ready():
	structures_dict = Global.structures_dict
	self.body_entered.connect(_on_Area_body_entered)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_Area_body_entered(body:Node) -> void:
	print("I'm hit!")
	pass
	
	
# for duplicates that do not construct themselves
func construct(key):
	structures_dict = Global.structures_dict
	print("Constructing ", key)
	# when created, generate the wall programmically
	sprite = $"Sprite2D"
	collision = $"CollisionShape2D"
	structure_values = structures_dict[key]
	# set the sprite
	image = Image.load_from_file(structure_values[0])
	sprite.texture = ImageTexture.create_from_image(image)
	# a funny little exception for tower_s
	if key == "tower_s":
		sprite.position.y = structure_values[4]
	# set the collision box size and position
	collision.shape.size = Vector2(structure_values[1], structure_values[2])
	collision.position.y = structure_values[3]
	pass
	
	
static func new_structure(dict_key: String):
	print("My ", dict_key, " body is rigid")
	var my_scene: PackedScene = load("res://scenes/physics_structure.tscn")
	var new_structure: PhysicsStructure = my_scene.instantiate().duplicate()
	return new_structure
