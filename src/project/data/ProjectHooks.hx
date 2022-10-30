package project.data;

import sys.io.File;
import js.node.vm.Script;

// 用于设置Project的钩子脚本，用于在数据IO时做一些定制的操作
class ProjectHooks
{
	private var script:Script;
	private var beforeLoadLevelFn:Dynamic;
	private var beforeSaveLevelFn:Dynamic;
	private var beforeSaveProjectFn:Dynamic;

	public function new(scriptFile:String = '') {
		set(scriptFile);
	}

	public function set(scriptFile:String) {
		if (scriptFile.length <= 0) {
			return;
		}

		if (!sys.FileSystem.exists(scriptFile) || sys.FileSystem.isDirectory(scriptFile)) {
			return;
		}

		var contents:String = File.getContent(scriptFile);
		script = new Script(contents, {filename: scriptFile});
		var scriptObject:Dynamic = script.runInThisContext();

		if (js.Lib.typeof(scriptObject) != "object") {
			return;
		}

		beforeLoadLevelFn = js.Lib.typeof(scriptObject.beforeLoadLevel) == "function" ? scriptObject.beforeLoadLevel : null;
		beforeSaveLevelFn = js.Lib.typeof(scriptObject.beforeSaveLevel) == "function" ? scriptObject.beforeSaveLevel : null;
		beforeSaveProjectFn = js.Lib.typeof(scriptObject.beforeSaveProject) == "function" ? scriptObject.beforeSaveProject : null; 
	}

	public function beforeLoadLevel(project:Project, data:Dynamic):Dynamic {
		if (beforeLoadLevelFn == null) {
			return data;
		}

		return beforeLoadLevelFn(project, data);
	}

	public function beforeSaveLevel(project:Project, data:Dynamic):Dynamic {
		if (beforeSaveLevelFn == null) {
			return data;
		}

		return beforeSaveLevelFn(project, data);
	}

	public function beforeSaveProject(project:Project, data:Dynamic):Dynamic {
		if (beforeSaveProjectFn == null) {
			return data;
		}

		return beforeSaveProjectFn(project, data);
	}
}