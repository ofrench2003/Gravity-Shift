extends Line2D

var line = Line2D
var trailLength = 20
var trailQueue : Array

func _physics_process(_delta: float) -> void:
	var pos = get_parent().get_node_or_null("player").global_position
	trailQueue.push_front(pos)
	if trailQueue.size() > trailLength:
		trailQueue.pop_back()
	clear_points()
	for point in trailQueue:
		add_point(point)
