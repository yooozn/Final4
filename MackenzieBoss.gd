extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var _animPlayer = $AnimationPlayer
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	_animPlayer.play("idle")
	$DetectionArea/CollisionShape2D.set_deferred("disabled",false)
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func attack():
	_animPlayer.play("IdleInvisible")
	var randomAttack = rng.randi_range(1,3)
	print(randomAttack)
	if randomAttack == 1:
		attack1()
	elif randomAttack == 2:
		attack2()
	elif randomAttack == 3:
		attack3()

func attack1():
	_animPlayer.play("attack1")
	yield(get_tree().create_timer(1),"timeout")
	attack()

func attack2():
	_animPlayer.play("attack2")
	yield(get_tree().create_timer(1),"timeout")
	attack()

func attack3():
	_animPlayer.play("attack3")
	yield(get_tree().create_timer(1),"timeout")

func _on_DetectionArea_body_entered(body):
	if body.is_in_group("Player"):
		$DetectionArea/CollisionShape2D.set_deferred("disabled",true)
		position += Vector2(-43,37)
		_animPlayer.play("start")
		yield(get_tree().create_timer(1.1),"timeout")
		position -= Vector2(-43,37)
		attack()
