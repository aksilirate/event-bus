tool
class_name _EventEditor
extends Control


onready var new_signal_line_edit = $HBoxContainer/VBoxContainer/HBoxContainer/NewSignalLineEdit
onready var events_container = $HBoxContainer/VBoxContainer/EventsContainer






func _on_CreateEventButton_pressed() -> void:
	add_event(new_signal_line_edit.text)
	update_events()


func _on_NewSignalLineEdit_text_entered(new_text: String) -> void:
	add_event(new_text)
	update_events()



func add_event(event_name: String):
	if event_name == "":
		return
	
	if not get_node("/root/Events").event_data.created_events.has(event_name):
		get_node("/root/Events").add_event(event_name)
		new_signal_line_edit.clear()






func update_events():
	for element in events_container.get_children():
		var child: Node = element
		child.queue_free()
	
	
	for element in get_node("/root/Events").event_data.created_events:
		var created_event_name: String = element
		var event_node = preload("res://addons/EventBus/EventNode/EventNode.tscn").instance()
		event_node.connect("event_deleted", self, "update_events")
		event_node.event_name = created_event_name
		events_container.add_child(event_node)

