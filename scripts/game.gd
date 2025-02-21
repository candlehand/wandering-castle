extends Node
## Handles main game screen functionality

# determines forward speed of castle
var castle_velocity = .5

# Called when the node enters the scene tree for the first time.
func _ready():
	# inits the random number generator
	randomize()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# slowly and steadily moves the castle forward
	$Castle.position.x += castle_velocity
	pass
