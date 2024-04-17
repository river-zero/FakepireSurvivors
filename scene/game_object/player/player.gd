extends CharacterBody2D

const MAX_SPEED = 125
const ACCELERATION_SMMOTHING = 25

@onready var damage_interver_timer = $DamageInterverTimer

var number_colliding_bodies = 0

func _ready():
	$CollisionArea2D.body_entered.connect(on_body_entered)
	$CollisionArea2D.body_exited.connect(on_body_exited)
	damage_interver_timer.timeout.connect(on_damage_interval_timer_timeout)

func _process(delta):
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	var target_velocity = direction * MAX_SPEED
	
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMMOTHING))
	
	move_and_slide()

func get_movement_vector():
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_movement, y_movement)
	
func check_deal_damage():
	if 	number_colliding_bodies == 0 || !damage_interver_timer.is_stopped():
		return
	$HealthComponent.damage(1)
	damage_interver_timer.start()
	print($HealthComponent.current_health)

func on_body_entered(other_body: Node2D):
	number_colliding_bodies += 1
	check_deal_damage()

func on_body_exited(other_body: Node2D):
	number_colliding_bodies -= 1

func on_damage_interval_timer_timeout():
	check_deal_damage()
