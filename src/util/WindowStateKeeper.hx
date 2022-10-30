package util;

import electron.main.BrowserWindow;

typedef WindowStateKeeperOptions =
{
	?defaultWidth:Int,
	?defaultHeight:Int,
	?path:String,
	?file:String,
	?maximize:Bool,
	?fullscreen:Bool
} 

// A library to store and restore window sizes and positions for your Electron app
// https://www.npmjs.com/package/electron-window-state
@:jsRequire('electron-window-state')
extern class WindowStateKeeper
{
	public var x:Int;
	public var y:Int;
	public var width:Int;
	public var height:Int;
	public var isMaximized:Bool;
	public var isFullscreen:Bool;

	@:selfCall
	public static function create(?options:WindowStateKeeperOptions):WindowStateKeeper;

	public function manage(window:BrowserWindow):Void;

	public function unmanage():Void;

	public function saveState(window:BrowserWindow):Void;
}