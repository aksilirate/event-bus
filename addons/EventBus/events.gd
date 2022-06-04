tool
extends Node


var event_data: _EventData = load(_EventData.PATH)
var tag_data: _TagData = load(_TagData.PATH)






func _init() -> void:
	for element in event_data.created_events:
		var tagged_event: _TaggedEvent = element
		add_user_signal(tagged_event.name)



func add_event(tagged_event: _TaggedEvent):
	event_data.created_events.push_back(tagged_event)
	property_list_changed_notify()
	ResourceSaver.save(_EventData.PATH, event_data)




func delete_event(tagged_event: _TaggedEvent):
	event_data.created_events.erase(tagged_event)
	property_list_changed_notify()
	ResourceSaver.save(_EventData.PATH, event_data)




func add_tag(event_tag: _EventTag):
	tag_data.created_tags.push_back(event_tag)
	ResourceSaver.save(_TagData.PATH, tag_data)



func delete_tag(event_tag: _EventTag):
	tag_data.created_tags.erase(event_tag)
	ResourceSaver.save(_TagData.PATH, tag_data)





func _get(property: String):
	var created_events_names: Array
	for element in event_data.created_events:
		var tagged_event: _TaggedEvent = element
		created_events_names.push_back(tagged_event.name)
		
	if created_events_names.has(property):
		return property
	



func _get_property_list() -> Array:
	var serialized_events: Array
	
	
	var created_events_names: Array
	for element in event_data.created_events:
		var tagged_event: _TaggedEvent = element
		created_events_names.push_back(tagged_event.name)
	
	
	for element in created_events_names:
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
