package modules.decals.tools;

import level.editor.Tool;

// Decal的笔刷行为
class DecalTool extends Tool
{
	public var layerEditor(get, never):DecalLayerEditor;
	function get_layerEditor():DecalLayerEditor return cast EDITOR.currentLayerEditor;

	public var layer(get, never):DecalLayer;
	function get_layer():DecalLayer return cast EDITOR.level.currentLayer;
}