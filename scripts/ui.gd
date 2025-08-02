extends Node

@onready var pause_menu: Panel = %PauseMenu

func _ready() -> void:
    pause_menu.hide()
    get_tree().paused = false

func _on_back_pressed() -> void:
    pause_menu.hide()
    get_tree().paused = false

func _on_main_menu_pressed() -> void:
    get_tree().paused = false
    get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_pause_pressed() -> void:
    pause_menu.show()
    get_tree().paused = true
