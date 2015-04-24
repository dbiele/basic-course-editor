package com.invision.view 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Dean Biele
	 */
	public class CaptionItemView extends MovieClip 
	{
		private var _xmlList:XML;
		public var caption_txt:TextField;
		public var time_txt:TextField;
		public var captiontitle_txt:TextField;
		
		public function CaptionItemView() 
		{
			
		}
		
		public function setXML(xmlList:XML):void {
			_xmlList = xmlList;
			captiontitle_txt.text = "Caption Text: "+_xmlList.name();
			caption_txt.text = _xmlList.@["captiontext"];
			time_txt.text = _xmlList.@["captiontime"];
			caption_txt.addEventListener(Event.CHANGE, onCaptionChangeHandler, false, 0, true);
			time_txt.addEventListener(Event.CHANGE, onTimeChangeHandler, false, 0, true);
		}
		
		private function onTimeChangeHandler(e:Event):void 
		{
			_xmlList.@["captiontime"] = time_txt.text;
		}
		
		private function onCaptionChangeHandler(e:Event):void 
		{
			_xmlList.@["captiontext"] = caption_txt.text;
		}
		
	}

}