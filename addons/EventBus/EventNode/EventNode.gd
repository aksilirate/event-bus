tool
extends HBoxContainer

signal event_deleted


onready var name_label = $HBoxContainer/NameLabel

export var event_name: String setget set_event_name

func set_event_name(value):
	event_name = value

func _ready() -> void:
	update_name()


func update_name():
	name_label.text = event_name


func _on_DeleteButton_pressed() -> void:
	get_node("/root/Events").delete_event(event_name)
	emit_signal("event_deleted")
