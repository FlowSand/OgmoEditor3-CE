package project.editor;

import js.jquery.JQuery;
import util.Vector;
import util.Color;
import util.Fields;

// 项目的基本属性页
class ProjectGeneralPanel extends ProjectEditorPanel
{
	public static function startup()
	{
		Ogmo.projectEditor.addPanel(new ProjectGeneralPanel());
	}

	public var projectName:JQuery;
	public var backgroundColor:JQuery;
	public var externalScript:JQuery;
	public var playCommand:JQuery;
	public var gridColor:JQuery;
	public var angleExport:JQuery;
	public var directoryDepth:JQuery;
	public var compactExport:JQuery;
	public var layerGridDefaultSize:JQuery;
	public var levelMinSize:JQuery;
	public var levelMaxSize:JQuery;
	public var levelValueManager:ValueTemplateManager;

	public function new()
	{
		super(0, "general", "General", "sliders");
		// general settings

        // 项目名、目录深度
		projectName = Fields.createField("Project Name");
		Fields.createSettingsBlock(root, projectName, SettingsBlock.TwoThirds, "Name", SettingsBlock.InlineTitle);

		directoryDepth = Fields.createField("00", "5");
		Fields.createSettingsBlock(root, directoryDepth, SettingsBlock.Third, "Project Directory Depth", SettingsBlock.InlineTitle);

		Fields.createLineBreak(root);

        // Hook脚本和命令
		externalScript = Fields.createFilepath("External Script", true, [{name: 'External Script', extensions: ['js']}], null, function() { Fields.setPath(externalScript, ''); });
		Fields.createSettingsBlock(root, externalScript, SettingsBlock.Half, "External Script", SettingsBlock.InlineTitle);

		playCommand = Fields.createField("Play Command", "");
		Fields.createSettingsBlock(root, playCommand, SettingsBlock.Half, "Play Command", SettingsBlock.InlineTitle);

		Fields.createLineBreak(root);

        // 编辑状态下的背景和Grid颜色
		backgroundColor = Fields.createColor("Background Color", Color.white, root);
		Fields.createSettingsBlock(root, backgroundColor, SettingsBlock.Half, "Bg Color", SettingsBlock.InlineTitle);

		gridColor = Fields.createColor("Grid Color", Color.white);
		Fields.createSettingsBlock(root, gridColor, SettingsBlock.Half, "Grid Color", SettingsBlock.InlineTitle);

		Fields.createLineBreak(root);

        // Json导出设置
		var options = new Map();
		options.set('0', 'Pretty');
		options.set('1', 'Compact');
		compactExport = Fields.createOptions(options);
		Fields.createSettingsBlock(root, compactExport, SettingsBlock.Third, "JSON Export Format", SettingsBlock.InlineTitle);

        // 角度设置
		options = new Map();
		options.set('0', 'Radians');
		options.set('1', 'Degrees');
		angleExport = Fields.createOptions(options);
		Fields.createSettingsBlock(root, angleExport, SettingsBlock.Third, "Angle Export Mode", SettingsBlock.InlineTitle);

        // Grid大小（默认8*8）
		layerGridDefaultSize = Fields.createVector(new Vector(0, 0));
		Fields.createSettingsBlock(root, layerGridDefaultSize, SettingsBlock.Third, "Layer Grid Default Size", SettingsBlock.InlineTitle);

		Fields.createLineBreak(root);

        // 关卡尺寸限制
		// level size
		levelMinSize = Fields.createVector(new Vector(0, 0));
		Fields.createSettingsBlock(root, levelMinSize, SettingsBlock.Half, "Min. Level Size", SettingsBlock.InlineTitle);
		levelMaxSize = Fields.createVector(new Vector(0, 0));
		Fields.createSettingsBlock(root, levelMaxSize, SettingsBlock.Half, "Max. Level Size", SettingsBlock.InlineTitle);

		// level custom fields
		levelValueManager = new ValueTemplateManager(root, [], 'Level Values');
	}

    // 页面打开时从OGMO.project中读取数据
	override function begin(reset:Bool = false):Void
	{
		Fields.setField(projectName, OGMO.project.name);
		Fields.setField(directoryDepth, OGMO.project.directoryDepth.string());
		Fields.setColor(backgroundColor, OGMO.project.backgroundColor);
		Fields.setColor(gridColor, OGMO.project.gridColor);
		compactExport.val(!OGMO.project.compactExport ? "0" : "1");
		Fields.setPath(externalScript, OGMO.project.externalScript);
		Fields.setField(playCommand, OGMO.project.playCommand);
		angleExport.val(OGMO.project.anglesRadians ? "0" : "1");
		Fields.setVector(layerGridDefaultSize, OGMO.project.layerGridDefaultSize);
		Fields.setVector(levelMinSize, OGMO.project.levelMinSize);
		Fields.setVector(levelMaxSize, OGMO.project.levelMaxSize);
		levelValueManager.inspect(null, false);
		levelValueManager.values = OGMO.project.levelValues;
		levelValueManager.refreshList();
	}

    // 页面关闭时将JQuery组件中的值填充回OGMO.project中
	override function end():Void
	{
		OGMO.project.name = projectName.val();
		OGMO.project.directoryDepth = Imports.integer(Fields.getField(directoryDepth), 16);
		OGMO.project.backgroundColor = Fields.getColor(backgroundColor);
		OGMO.project.gridColor = Fields.getColor(gridColor);
		OGMO.project.compactExport = compactExport.val() != "0";
		OGMO.project.externalScript = Fields.getPath(externalScript);
		OGMO.project.playCommand = Fields.getField(playCommand);
		OGMO.project.anglesRadians = angleExport.val() == "0";
		OGMO.project.layerGridDefaultSize = Fields.getVector(layerGridDefaultSize);
		OGMO.project.levelMinSize = Fields.getVector(levelMinSize);
		OGMO.project.levelMaxSize = Fields.getVector(levelMaxSize);
		levelValueManager.save();
		OGMO.project.levelValues = levelValueManager.values;
	}
}
