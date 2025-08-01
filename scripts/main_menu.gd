extends Control

@onready var settings: Panel = $Settings
@onready var main_buttons: VBoxContainer = $MainMenu/MainButtons

func _on_start_pressed() -> void:
    get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_settings_pressed() -> void:
    main_buttons.hide()
    settings.show()

func _on_quit_pressed() -> void:
    get_tree().quit()

func _on_back_pressed() -> void:
    get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
