extends CanvasLayer

func _ready() -> void:
    hide()

func _on_player_enemy_close(had_passed_tutorial: bool) -> void:
    if !Engine.time_scale == 1:
        return

    if had_passed_tutorial:
        Engine.time_scale = 0.8
    else:
        Engine.time_scale = 0.05
        show()

func _on_player_enemy_not_close() -> void:
    Engine.time_scale = 1
    hide()
