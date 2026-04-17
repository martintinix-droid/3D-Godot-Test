extends RigidBody3D

signal died
signal despawned
@onready var hurt_sound = %HurtSound
@onready var die_sound = %DieSound

@onready var bat_model = %bat_model
@onready var timer = %Timer

@onready var player = get_node("/root/Game/Player")

var health=3
var speed = randf_range(2.0,4.0)


func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	direction.y =0.0
	linear_velocity = direction * speed
	bat_model.rotation.y= Vector3.FORWARD.signed_angle_to(direction, Vector3.UP)+PI

func take_damage():
	if health==0:
		return
	bat_model.hurt()
	hurt_sound.play()
	health-=1
	if health==0:
		set_physics_process(false)
		die_sound.play()
		gravity_scale=1.0
		var direction = -1.0*global_position.direction_to(player.global_position)
		var random_upward_force=Vector3.UP*randf_range(1.0,5.0)
		apply_central_impulse(direction*10+random_upward_force)
		timer.start()
		died.emit()


func _on_timer_timeout():
	queue_free()
	despawned.emit()
