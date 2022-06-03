tool
extends Node

signal created_events_changed


var event_data: _EventData = preload("res://addons/EventBus/EventData.tres")



func _init() -> void:
	for element in event_data.created_events:
		var event_name: String = element
		add_user_signal(event_name)


func add_event(event_name: String):
	event_data.created_events.push_back(event_name)
	property_list_changed_notify()
	ResourceSaver.save("res://addons/EventBus/EventData.tres", event_data)
	emit_signal("created_events_changed")




func delete_event(event_name: String):
	event_data.created_events.erase(event_name)
	property_list_changed_notify()
	ResourceSaver.save("res://addons/EventBus/EventData.tres", event_data)
	emit_signal("created_events_changed")




func _get(property: String):
	if event_data.created_events.has(property):
		return property
	



func _get_property_list() -> Array:
	var serialized_events: Array
	
	for element in event_data.created_events:
		var event_name: String = element
		serialized_events.push_back({
			"name": event_name,
			"type": TYPE_STRING
		})

	return serialized_events
