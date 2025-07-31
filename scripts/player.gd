extends CharacterBody2D

@export var planet_center: Vector2
@export var planet_radius := 120
@export var player_height := 70
@export var move_speed := 200

var facing_left := false
var is_slashing := false

func _physics_process(delta) -> void:    
    if is_slashing:
        return

    if Input.is_action_just_pressed("ui_accept"):
        slash()

    var to_player = global_position - planet_center
    var normal = to_player.normalized()

    global_position = planet_center + normal * (planet_radius + player_height)

    rotation = normal.angle() + PI / 2

    var tangent = Vector2(normal.y, -normal.x) if facing_left else Vector2(-normal.y, normal.x)

    global_position += tangent * move_speed * delta

func slash() -> void:
    is_slashing = true
    await get_tree().process_frame

    for area in $AttackArea.get_overlapping_areas():
        print(area.name)
        if area.is_in_group("enemies"):
            print("Hit enemy!")
            area.die()

    $AnimatedSprite2D.play("attack")
    await $AnimatedSprite2D.animation_finished
    $AnimatedSprite2D.play("walk")

    facing_left = !facing_left
    $AnimatedSprite2D.flip_h = facing_left

    is_slashing = false
