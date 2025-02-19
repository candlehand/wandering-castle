extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	# this is sus. We will see. SHould make the background minimum size the size of the viewport
	custom_minimum_size = get_viewport().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
