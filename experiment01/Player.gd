extends KinematicBody2D

var tile_size = 64
var file = null
var valid_cmd = ["move", "msg"]

var inputs = {
	"up": Vector2.UP,
	"down": Vector2.DOWN,
	"left": Vector2.LEFT,
	"right": Vector2.RIGHT
}

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size / 2
	
	# load a text file
	file = File.new()
	file.open("res://scenarios/001.txt", File.READ)
	var content = file.get_as_text()
	file.close()
#	print(content)
	parse_and_execute(content)

func parse_and_execute(content):
	var commands = Array(content.split("\n"))
	for item in commands:
#		print("Item is: %s" % typeof(item))
		var cmd = Array(item.split(" "))
		var fn = cmd.pop_front()
		print(item)
		get_tree().call_group("master", "debug_message", item)
		if fn in valid_cmd and self.has_method(fn):
			match fn:
				"move":
					callv(fn, cmd)
				"msg":
					var message = PoolStringArray(cmd).join(" ")
					callv(fn, [message])
		else:
			print("Method %s not implemented yet or not in valid command list!" % fn)
		# do a dramatic pause
		yield(get_tree().create_timer(0.5), "timeout")

func move(dir):
#	print("Will move: %s %s" % [dir, inputs[dir]] )
	position += inputs[dir] * tile_size
	

func msg(message):
	get_tree().call_group("master", "play_message", message)


# Method that will:
# 	Read a file of lines
# 	convert each line to array with split
# 	perform callv:
# 	one line example:
#		var test = Array("move up".split(" "))
#		callv(test.pop_front(), test)
