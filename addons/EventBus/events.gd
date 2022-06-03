tool
extends Node


var event_data: _EventData = load(_EventData.PATH)
var tag_data: _TagData = load(_TagData.PATH)






func _init() -> void:
	for element in event_data.created_events:
		var event_name: String = element
		add_user_signal(event_name)



func add_event(event_name: String):
	event_data.created_events.push_back(event_name)
	property_list_changed_notify()
	ResourceSaver.save(_EventData.PATH, event_data)




func delete_event(event_name: String):
	event_data.created_events.erase(event_name)
	property_list_changed_notify()
	ResourceSaver.save(_EventData.PATH, event_data)




func add_tag(tag_name: String):
	tag_data.created_tags.push_back(tag_name)
	ResourceSaver.save(_TagData.PATH, event_data)



func delete_tag(tag_name: String):
	tag_data.created_tags.erase(tag_name)
	ResourceSaver.save(_TagData.PATH, event_data)





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
		serialized_events.push_back({
			"name": "_on_" + event_name,
			"type": TYPE_STRING
		})

	return serialized_events
