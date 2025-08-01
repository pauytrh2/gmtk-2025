extends Area2D

signal killed

@export var planet_center: Vector2

const planet_radius := 120
const enemy_height := 35
const min_distance_from_player := 200.0

var facing_left := false
var player: Node2D = null

func _ready() -> void:
    if player == null:
        push_warning("Enemy missing reference to player.")
        queue_free()
        return

    var max_attempts := 10
    var attempt := 0
    var angle := 0.0
    var normal := Vector2.ZERO
    var spawn_position := Vector2.ZERO

    while attempt < max_attempts:
        angle = randf() * TAU
        normal = Vector2(cos(angle), sin(angle))
        spawn_position =  planet_center + normal * (planet_radius + enemy_height)

        if spawn_position.distance_to(player.global_position) >= min_distance_from_player:
            break
        attempt += 1

    if attempt >= max_attempts:
        push_warning("Could not find valid spawn point for enemy")
        queue_free()
        return

    global_position = spawn_position
    rotation = normal.angle() + PI / 2

func die() -> void:
    emit_signal("killed")
    queue_free()
