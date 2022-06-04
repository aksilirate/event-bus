tool
class_name _EventEditor
extends Control


onready var new_signal_line_edit = $HBoxContainer/VBoxContainer/HBoxContainer/NewSignalLineEdit
onready var events_container = $HBoxContainer/VBoxContainer/MarginContainer/EventsContainer
onready var new_tag_line_edit = $HBoxContainer/VBoxContainer2/HBoxContainer/NewTagLineEdit
onready var tags_container = $HBoxContainer/VBoxContainer2/TagsContainer

onready var all_tags = $HBoxContainer/VBoxContainer2/EventTag

var selected_tag: _EventTag setget set_selected_tag



func _ready() -> void:
	all_tags.connect("tag_selected", self, "_on_tag_selected")


func set_selected_tag(value):
	selected_tag = value
	update_events()



func add_event(event_name: String):
	if event_name == "":
		return
	
	var tagged_event = _TaggedEvent.new()
	tagged_event.name = event_name
	
	
	for element in get_node("/root/Events").event_data.created_events:
		var arg_tagged_event: _TaggedEvent = element
		if arg_tagged_event.name == event_name:
			return
	
	get_node("/root/Events").add_event(tagged_event)
	new_signal_line_edit.clear()



func add_tag(tag_name: String):
	if tag_name == "":
		return
		
	var event_tag = _EventTag.new()
	event_tag.name = tag_name
	
	for element in get_node("/root/Events").tag_data.created_tags:
		var arg_event_tag: _EventTag = element
		if arg_event_tag.name == tag_name:
			return
	
	get_node("/root/Events").add_tag(event_tag)
	new_tag_line_edit.clear()




func update_events():
	for element in events_container.get_children():
		var child: Node = element
		child.queue_free()
	
	
	for element in get_node("/root/Events").event_data.created_events:
		var tagged_event: _TaggedEvent = element
		if selected_tag != null:
			if tagged_event.tag != selected_tag:
				continue
			
		var event_node = preload("res://addons/EventBus/EventNode/EventNode.tscn").instance()
		event_node.connect("event_deleted", self, "update_events")
		event_node.tagged_event = tagged_event
		events_container.add_child(event_node)





func update_tags():
	all_tags.pressed = selected_tag == null
	
	for element in tags_container.get_children():
		var child: Node = element
		child.queue_free()
	
	
	for element in get_node("/root/Events").tag_data.created_tags:
		var event_tag: _EventTag = element
		var tag_node = preload("res://addons/EventBus/TagNode/TagNode.tscn").instance()
		tag_node.connect("tag_selected", self, "_on_tag_selected")
		tag_node.connect("tag_deleted", self, "_on_tag_deleted")
		tag_node.connect("color_updated", self, "_on_color_updated")
		tag_node.event_tag = event_tag
		tag_node.pressed = selected_tag == event_tag
		tags_container.add_child(tag_node)



func _on_tag_selected(arg_selected_tag):
	selected_tag = arg_selected_tag
	update_events()
	update_tags()



func _on_tag_deleted():
	update_tags()
	update_events()


func _on_color_updated():
	update_events()



func _on_CreateEventButton_pressed() -> void:
	add_event(new_signal_line_edit.text)
	update_events()


func _on_NewSignalLineEdit_text_entered(new_text: String) -> void:
	add_event(new_text)
	update_events()



func _on_CreateTagButton_pressed() -> void:
	add_tag(new_tag_line_edit.text)
	update_tags()


func _on_NewTagLineEdit_text_entered(new_text: String) -> void:
	add_tag(new_text)
	update_tags()
