extends Node

@onready var pause_menu: Panel = %PauseMenu
@onready var sfx_player: AudioStreamPlayer = $"../SFXPlayer"

func _ready() -> void:
    pause_menu.hide()
    get_tree().paused = false

func _on_back_pressed() -> void:
    play_sound()
    pause_menu.hide()
    get_tree().paused = false

func _on_main_menu_pressed() -> void:
    play_sound()
    get_tree().paused = false
    get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_pause_pressed() -> void:
    play_sound()
    pause_menu.show()
    get_tree().paused = true

func play_sound() -> void:
    sfx_player.play()
