extends Node

var Id = "TS"

func _process(delta):
	UpdateUI(TranslationServer.get_locale())

func UpdateUI(lang : String):
	TranslationServer.set_locale(lang)
	var nodes = get_tree().get_nodes_in_group("UI")
	for node in nodes:
		if node.get_child_count() > 0:
			nodes.append_array(node.get_children())
		if node is BaseButton || node is Label:
			node.text = tr(node.name)
