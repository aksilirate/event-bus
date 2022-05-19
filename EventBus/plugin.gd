tool
extends EditorPlugin

var event_editor


func _enter_tree() -> void:
	add_autoload_singleton("Events", "res://addons/EventBus/events.gd")
	
	event_editor = preload("res://addons/EventBus/EventEditor/EventEditor.tscn").instance()
	
	get_editor_interface().get_editor_viewport().add_child(event_editor)
	
	make_visible(false)







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
