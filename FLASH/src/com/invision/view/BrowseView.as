package com.invision.view 
{
	import com.invision.client.components.BasicButton;
	import com.invision.events.BrowseEvent;
	import com.invision.view.windows.BaseWindow;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Dean Biele
	 */
	public class BrowseView extends BaseWindow 
	{
		public var browse_btn:MovieClip;
		public var filename_txt:TextField;
		
		private var _browseButton:BasicButton;
		
		public function BrowseView() 
		{
			super();
			x = 220;
			y = 241;
			_browseButton = new BasicButton("browse", browse_btn);
			_browseButton.addEventListener(MouseEvent.MOUSE_UP, onBrowseHandler, false, 0, true);
		}
		
		public function setLoadedFileName(fileName:String):void 
		{
			filename_txt.text = fileName;
		}
		
		private function onBrowseHandler(e:MouseEvent):void 
		{
			var browseEvent:BrowseEvent = new BrowseEvent(BrowseEvent.SELECTED);
			dispatchEvent(browseEvent);
		}
		
	}

}