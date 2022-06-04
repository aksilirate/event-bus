tool
extends EditorPlugin


var event_editor: _EventEditor


func _enter_tree() -> void:
	connect("main_screen_changed", self, "_on_main_screen_changed")
	add_autoload_singleton("Events", "res://addons/EventBus/events.gd")
	
	event_editor = preload("res://addons/EventBus/EventEditor/EventEditor.tscn").instance()
	
	get_editor_interface().get_editor_viewport().add_child(event_editor)
	
	
	var dir = Directory.new()
	if not dir.file_exists(_EventData.PATH):
		var event_data = _EventData.new()
		ResourceSaver.save(_EventData.PATH, event_data)
		get_node("/root/Events").event_data = load(_EventData.PATH)
		
		
	if not dir.file_exists(_TagData.PATH):
		var tag_data = _TagData.new()
		ResourceSaver.save(_TagData.PATH, tag_data)
		get_node("/root/Events").tag_data = load(_TagData.PATH)
	
	make_visible(false)




func _on_main_screen_changed(screen_name: String):
	if screen_name == "Events":
		event_editor.update_events()
		event_editor.update_tags()
	




func _exit_tree() -> void:
	remove_autoload_singleton("Events")
	
	if event_editor:
		event_editor.queue_free()
	
	

func has_main_screen() -> bool:
	return true



func get_plugin_icon() -> Texture:
	return preload("res://addons/EventBus/icons/icon.png")


func get_plugin_name() -> String:
	return "Events"
