extends CharacterBody2D

@export var planet_center: Vector2
@export var planet_radius := 120
@export var player_height := 70
@export var move_speed := 200

var facing_left := false  

func _physics_process(delta):
    var to_player = global_position - planet_center
    var normal = to_player.normalized()

    global_position = planet_center + normal * (planet_radius + player_height)

    rotation = normal.angle() + PI / 2

    var tangent = Vector2(normal.y, -normal.x) if facing_left else Vector2(-normal.y, normal.x)

    global_position += tangent * move_speed * delta

    if Input.is_action_just_pressed("ui_accept"):
        slash()

func slash():
    facing_left = !facing_left
    $AnimatedSprite2D.flip_h = facing_left
    print("Slash! Facing left:", facing_left)
