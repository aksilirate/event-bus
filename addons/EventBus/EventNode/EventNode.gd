tool
extends HBoxContainer

signal event_deleted


onready var name_label = $HBoxContainer/NameLabel
onready var tag_color = $HBoxContainer/CenterContainer/TagColorRect
onready var tag_selection_dialog = $HBoxContainer/CenterContainer/TagSelectButton/TagSelectionDialog
onready var tag_selection_container = $HBoxContainer/CenterContainer/TagSelectButton/TagSelectionDialog/MarginContainer/ScrollContainer/TagSelectionContainer


var tagged_event: _TaggedEvent setget set_tagged_event



func set_tagged_event(value):
	tagged_event = value
	update_name()
	update_tag_color()




func _ready() -> void:
	update_name()
	update_tag_color()


func update_name():
	if name_label == null:
		return
		
	name_label.text = tagged_event.name



func update_tag_selection():
	for element in tag_selection_container.get_children():
		var node: Node = element
		node.queue_free()
	
	for element in get_node("/root/Events").tag_data.created_tags:
		var event_tag: _EventTag = element
		var tag_selection = preload("res://addons/EventBus/TagSelection/TagSelection.tscn").instance()
		tag_selection.event_tag = event_tag
		tag_selection.connect("tag_selected", self, "_on_tag_selected")
		tag_selection_container.add_child(tag_selection)
	


func _on_tag_selected(selected_tag: _EventTag):
	tag_selection_dialog.hide()
	tagged_event.tag = selected_tag
	update_tag_color()
	ResourceSaver.save(_EventData.PATH, get_node("/root/Events").event_data)


func update_tag_color():
	if tag_color == null:
		return
	
	var tag_data = load(_TagData.PATH)
	for element in tag_data.created_tags:
		var event_tag: _EventTag = element
		if event_tag.name == tagged_event.tag.name:
			tag_color.color = tagged_event.tag.color
			return
			
	tag_color.color = Color.white



func _on_DeleteButton_pressed() -> void:
	get_node("/root/Events").delete_event(tagged_event)
	emit_signal("event_deleted")


func _on_TagSelectButton_pressed() -> void:
	tag_selection_dialog.popup()


func _on_TagSelectionDialog_about_to_show() -> void:
	update_tag_selection()
