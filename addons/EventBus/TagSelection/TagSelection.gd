tool
extends MarginContainer


signal tag_selected(tag)

onready var name_label = $HBoxContainer/Label
onready var tag_color = $HBoxContainer/ColorRect


var event_tag: _EventTag setget set_event_tag



func set_event_tag(value):
	event_tag = value
	update_color()



func _ready() -> void:
	update_name()
	update_color()




func update_name():
	if event_tag != null:
		name_label.text = event_tag.name
		return
	name_label = "error loading tag"



func update_color():
	if event_tag != null:
		tag_color.color = event_tag.color
		return
	tag_color.color = Color.white


func _on_SelectButton_pressed() -> void:
	emit_signal("tag_selected", event_tag)
