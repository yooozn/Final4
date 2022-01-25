extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var _animPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	_animPlayer.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_DetectionArea_body_entered(body):
	if body.is_in_group("Player"):
		position += Vector2(-43,37)
		_animPlayer.play("start")
		yield(get_tree().create_timer(1.1),"timeout")
		_animPlayer.play("idle")
		position -= Vector2(-43,37)
