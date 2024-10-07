extends CharacterBody2D

## ANIMATION VARIABLES ##
@onready var animation = $AnimationTree
var blendSpeed = 15
var downVal = 0
var leftVal = 0
var rightVal = 0

## TRAIL VARIABLES ##
var trailScene = preload("res://Scenes&Scripts/player/trail.tscn")

## CONTROL VARIABLES ##
enum {UP, DOWN, LEFT, RIGHT}
var gravity = 20
var direction = Vector2(0, gravity)
var directionMagnitude = DOWN
var slowSpeed = 10


func _ready() -> void:
	var trailInstance = trailScene.instantiate()
	add_sibling.call_deferred(trailInstance)


func _physics_process(delta: float) -> void:
	
	
	## CONTROLS ##
	if Input.is_action_just_pressed("fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	
	## GRAVITY CONTROL ##
	if Input.is_action_pressed("up"):
		direction = Vector2(0, -gravity)
		directionMagnitude = UP
	elif Input.is_action_pressed("down"):
		direction = Vector2(0, gravity)
		directionMagnitude = DOWN
	elif Input.is_action_pressed("left"):
		direction = Vector2(-gravity, 0)
		directionMagnitude = LEFT
	elif Input.is_action_pressed("right"):
		direction = Vector2(gravity, 0)
		directionMagnitude = RIGHT
	
	velocity += direction
	move_and_slide()


	## FRICTION
	if (is_on_floor() or is_on_ceiling()) and directionMagnitude in [UP, DOWN]:
		velocity.x = lerpf(velocity.x, 0, delta * slowSpeed)
	if is_on_wall():
		if directionMagnitude in [LEFT, RIGHT]:
			velocity.y = lerpf(velocity.y, 0, delta * slowSpeed)
	
	
	## ANIMATIONS ##
	animation["parameters/down/blend_amount"] = downVal
	animation["parameters/left/blend_amount"] = leftVal
	animation["parameters/right/blend_amount"] = rightVal
	
	match directionMagnitude:
		UP:
			downVal = lerpf(downVal, 0, blendSpeed * delta)
			leftVal = lerpf(leftVal, 0, blendSpeed * delta)
			rightVal = lerpf(rightVal, 0, blendSpeed * delta)
		DOWN:
			downVal = lerpf(downVal, 1, blendSpeed * delta)
			leftVal = lerpf(leftVal, 0, blendSpeed * delta)
			rightVal = lerpf(rightVal, 0, blendSpeed * delta)
		LEFT:
			downVal = lerpf(downVal, 0, blendSpeed * delta)
			leftVal = lerpf(leftVal, 1, blendSpeed * delta)
			rightVal = lerpf(rightVal, 0, blendSpeed * delta)
		RIGHT:
			downVal = lerpf(downVal, 0, blendSpeed * delta)
			leftVal = lerpf(leftVal, 0, blendSpeed * delta)
			rightVal = lerpf(rightVal, 1, blendSpeed * delta)
	
