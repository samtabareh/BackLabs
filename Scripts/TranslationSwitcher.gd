extends Node

var is_default = true

func _process(delta):
	UpdateUI(TranslationServer.get_locale())

func UpdateUI(lang : String):
	TranslationServer.set_locale(lang)
	is_default = false if lang != "en" else true
	var nodes = get_tree().get_nodes_in_group("UI")
	for node in nodes:
		if node.get_child_count() > 0:
			nodes.append_array(node.get_children())
		if node is BaseButton:
			node.text = tr(node.name)
		if node is Label:
			node.text = tr(node.name)
