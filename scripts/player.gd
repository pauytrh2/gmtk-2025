extends CharacterBody2D

@export var planet_center: Vector2
@export var planet_radius := 100.0  # Set to your planet’s radius
@export var player_height := 16.0   # Distance from player center to feet, adjust as needed
@export var move_speed := 150.0

func _physics_process(delta):
    # Vector from planet center to player
    var to_player = global_position - planet_center
    var dist = to_player.length()

    # Normalize direction from center to player (surface normal)
    var normal = to_player.normalized()

    # Stick the player exactly to the surface (radius + player "foot" offset)
    global_position = planet_center + normal * (planet_radius + player_height)

    # Align rotation: face "away" from planet center
    rotation = normal.angle() + PI / 2

    # Movement input along the tangent
    var input_dir = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

    # Tangent vector (90 degrees rotated from normal)
    var tangent = Vector2(-normal.y, normal.x)

    # Move player position along tangent
    global_position += tangent * input_dir * move_speed * delta
