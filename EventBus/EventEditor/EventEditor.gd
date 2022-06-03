tool
class_name _EventEditor
extends Control


onready var new_signal_line_edit = $VBoxContainer/HBoxContainer/NewSignalLineEdit
onready var events_container = $VBoxContainer/EventsContainer


func _init() -> void:
	Events.connect("created_events_changed", self, "_on_created_events_changed")



func _on_CreateEventButton_pressed() -> void:
	add_event(new_signal_line_edit.text)



func _on_NewSignalLineEdit_text_entered(new_text: String) -> void:
	add_event(new_text)




func add_event(event_name: String):
	if event_name == "":
		return
	
	if not Events.event_data.created_events.has(event_name):
		Events.add_event(event_name)
		new_signal_line_edit.clear()



func _on_created_events_changed():
	update_events()



func update_events():
	for element in events_container.get_children():
		var child: Node = element
		child.queue_free()
	
	
	for element in Events.event_data.created_events:
		var created_event_name: String = element
		var event_node = preload("res://addons/EventBus/EventNode/EventNode.tscn").instance()
		event_node.event_name = created_event_name
		events_container.add_child(event_node)

