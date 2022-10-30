package util;

// 用于格式化Json的输出格式，以性能为代价在compact和pretty之间折中
// https://www.npmjs.com/package/@aitodotai/json-stringify-pretty-compact
@:jsRequire('@aitodotai/json-stringify-pretty-compact')
extern abstract Stringify (String) to String {
	@:selfCall
	public function new(obj:Dynamic, ?options:{?maxLength:Dynamic, ?maxNesting:Dynamic, ?margins:Bool, ?arrayMargins:Bool, ?objectMargins:Bool, ?indent:Int, ?replacer:String});
}