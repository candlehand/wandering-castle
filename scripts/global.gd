extends Node
## Global autoload script; contains values that must be accessed across scenes

# wall params dictionary
var structures_dict = {
	"wall_s": ["res://assets/Sunset Castle/Wall Small Sunset.png", 32, 46, 1],
	"wall_m": ["res://assets/Sunset Castle/Wall Medium Sunset.png", 64, 46, 1],
	"wall_l": ["res://assets/Sunset Castle/Wall Large Sunset.png", 96, 46 , 1],
	"tower_s": ["res://assets/Sunset Castle/Tower Medium Sunset.png", 48, 104, 4],
	"tower_l": ["res://assets/Sunset Castle/Tower Large Sunset.png", 62, 135, 4.5]
}

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Global script reporting for duty!")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
