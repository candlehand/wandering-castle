extends Node
## Global autoload script; contains values that must be accessed across scenes

# wall params dictionary
var structures_dict = {
	"wall_s": ["res://assets/Wall Small Asset.png", 32, 46, 1],
	"wall_m": ["res://assets/Wall Medium Asset.png", 64, 46, 1],
	"wall_l": ["res://assets/Wall Large Asset.png", 96, 46 , 1],
	"tower_s": ["res://assets/Tower Small Asset.png", 48, 104, 4],
	"tower_l": ["res://assets/Tower Tall Asset.png", 62, 135, 4.5]
}

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Global script reporting for duty!")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
