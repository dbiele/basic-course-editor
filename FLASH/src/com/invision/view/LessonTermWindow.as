package com.invision.view 
{
	import com.invision.client.components.BasicButton;
	import com.invision.events.GlossaryTermEvent;
	import com.invision.events.LessonTermEvent;
	import com.invision.events.ReferenceTermEvent;
	import com.invision.view.windows.SceneWindow;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Dean Biele
	 */
	public class LessonTermWindow extends SceneWindow 
	{
		public var title_txt:TextField;
		
		private var _deleteBasicButton:BasicButton;
		private var _xmlList:XMLList;
		
		private var _selectedID:String;
		
		public function LessonTermWindow() 
		{
			
		}
		
		override public function setXML(xmlList:XMLList):void {
			_xmlList = xmlList;
			_selectedID = _xmlList.@["id"];
			title_txt.text = _xmlList.@["name"];
			title_txt.addEventListener(Event.CHANGE, onNameChangeHandler, false, 0, true);
		}
		
		private function onNameChangeHandler(e:Event):void 
		{
			var currentText:TextField = e.currentTarget as TextField;
			_xmlList.@["name"] = currentText.text;
			var lessontermEvent:LessonTermEvent = new LessonTermEvent(LessonTermEvent.UPDATE);
			lessontermEvent.selectedID = _selectedID;
			dispatchEvent(lessontermEvent);
		}
		
	}

}