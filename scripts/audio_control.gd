extends HSlider

@export var audio_bus_name: String

func _ready() -> void:
    AudioServer.set_bus_volume_db(AudioServer.get_bus_index(audio_bus_name), linear_to_db(0.5))

func _on_value_changed(new_value: float) -> void:
    var decibals = linear_to_db(new_value)
    AudioServer.set_bus_volume_db(AudioServer.get_bus_index(audio_bus_name), decibals)
