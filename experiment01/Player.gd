extends KinematicBody2D

var tile_size = 64;

var inputs = {
	"up": Vector2.UP,
	"down": Vector2.DOWN,
	"left": Vector2.LEFT,
	"right": Vector2.RIGHT
}

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size / 2

func move(dir):
	print("Will move: %s %s" % [dir, inputs[dir]] )

# Method that will:
# 	Read a file of lines
# 	convert each line to array with split
# 	perform callv:
# 	one line example:
#		var test = Array("move up".split(" "))
#		callv(test.pop_front(), test)
