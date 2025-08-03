extends Control

@onready var settings: Panel = $Settings
@onready var main_buttons: VBoxContainer = $MainMenu/MainButtons
@onready var sfx_player: AudioStreamPlayer = $SFXPlayer

func _ready() -> void:
    main_buttons.show()
    settings.hide()

func _on_start_pressed() -> void:
    play_sound()
    get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_settings_pressed() -> void:
    play_sound()
    main_buttons.hide()
    settings.show()

func _on_quit_pressed() -> void:
    play_sound()
    get_tree().quit()

func _on_back_pressed() -> void:
    play_sound()
    _ready()

func play_sound() -> void:
    sfx_player.play()
