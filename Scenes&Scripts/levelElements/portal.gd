extends Area2D


func _ready() -> void:
	$AnimatedSprite2D.play("default")
	$AnimatedSprite2D2.play("default")

func _physics_process(_delta: float) -> void:
	$AnimatedSprite2D.rotation_degrees += 0.75
	$AnimatedSprite2D2.rotation_degrees -= 0.5
