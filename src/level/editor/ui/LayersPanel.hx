package level.editor.ui;

import js.Browser;
import js.jquery.JQuery;

// Editor界面Layer子窗口
class LayersPanel extends SidePanel
{
	public var buttons: Array<LayerButton> = [];

    // populate: 填充， 主要是根据数据生成出控件实例
	override function populate(into:JQuery):Void
	{
		buttons.resize(0);
		into.empty();

		var height:Float = 0;
		for (i in 0...OGMO.project.layers.length)
		{
			var button = new LayerButton(OGMO.project.layers[i], i);
			buttons.push(button);
			into.append(button.jqRoot);
			height += button.jqRoot.height();
		}

		into.height(Math.min(new JQuery(Browser.window).height() / 2, Math.max(64, height)));
	}

    // 刷新选中表现
	override function refresh():Void
	{
		for (i in 0...OGMO.project.layers.length)
		{
			if (EDITOR.level.currentLayerID == i) buttons[i].selected();
			else buttons[i].notSelected();
		}
	}
}