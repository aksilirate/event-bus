tool
extends MarginContainer

signal tag_selected(tag)
signal color_updated
signal tag_deleted



onready var name_label = $VBoxContainer/Label
onready var color_picker_button = $VBoxContainer/CenterContainer/ColorPickerButton
onready var select_button = $SelectButton

export var pressed: bool setget set_pressed
var event_tag: _EventTag setget set_event_tag


func set_pressed(value):
	pressed = value
	if select_button != null:
		select_button.pressed = pressed


func set_event_tag(value):
	event_tag = value
		
	update_name()
	update_color()



func _ready() -> void:
	select_button.pressed = pressed
	
	update_name()
	update_color()




func update_name():
	if name_label == null:
		return
		
	if event_tag != null:
		name_label.text = event_tag.name
		return
		
	name_label.text = "all tags"




func update_color():
	if color_picker_button == null:
		return
		
	if event_tag != null:
		color_picker_button.color = event_tag.color
		return
	color_picker_button.color = Color.white




func _on_DeleteButton_pressed() -> void:
	if event_tag != null:
		get_node("/root/Events").delete_tag(event_tag)
		emit_signal("tag_deleted")



func _on_ColorPickerButton_color_changed(arg_color: Color) -> void:
	print(event_tag)
	if event_tag != null:
		event_tag.color = arg_color
		emit_signal("color_updated")
		ResourceSaver.save(_TagData.PATH, get_node("/root/Events").tag_data)


func _on_SelectButton_pressed() -> void:
	emit_signal("tag_selected", event_tag)
