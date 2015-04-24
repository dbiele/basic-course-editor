package com.invision.view 
{
	import com.invision.client.components.BasicButton;
	import com.invision.events.GlossaryTermEvent;
	import com.invision.events.ReferenceTermEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Dean Biele
	 */
	public class ReferenceTermWindow extends MovieClip 
	{
		public var delete_btn:MovieClip;
		public var name_txt:TextField;
		public var icon_txt:TextField;
		public var file_txt:TextField;
		
		private var _deleteBasicButton:BasicButton;
		private var _xmlList:XMLList;
		
		private var _selectedID:String
		
		public function ReferenceTermWindow() 
		{
			_deleteBasicButton = new BasicButton("delete", delete_btn);
			_deleteBasicButton.addEventListener(MouseEvent.MOUSE_UP, onDeleteHandler, false, 0, true);
		}
		
		public function setXML(xmlList:XMLList):void {
			_xmlList = xmlList;
			
			icon_txt.text = _xmlList.@["icon"];
			file_txt.text = _xmlList.@["link"];
			name_txt.text = _xmlList.toString();
			
			icon_txt.addEventListener(Event.CHANGE, onIconChangeHandler, false, 0, true);
			file_txt.addEventListener(Event.CHANGE, onFileChangeHandler, false, 0, true);
			name_txt.addEventListener(Event.CHANGE, onNameHandler, false, 0, true);
		}
		
		private function onFileChangeHandler(e:Event):void 
		{
			var currentText:TextField = e.currentTarget as TextField;
			_xmlList.@["link"] = currentText.text;
			var referencetermEvent:ReferenceTermEvent = new ReferenceTermEvent(ReferenceTermEvent.UPDATE);
			dispatchEvent(referencetermEvent);
		}
		
		private function onIconChangeHandler(e:Event):void 
		{
			var currentText:TextField = e.currentTarget as TextField;
			_xmlList.@["icon"] = currentText.text;
		}
		
		private function onNameHandler(e:Event):void 
		{
			var currentText:TextField = e.currentTarget as TextField;
			_xmlList.setChildren(XML("<![CDATA[" + currentText.text + "]]>"));
		}
		
		private function onDeleteHandler(e:MouseEvent):void 
		{
			var referencetermEvent:ReferenceTermEvent = new ReferenceTermEvent(ReferenceTermEvent.DELETE);
			referencetermEvent.selectedID = file_txt.text;
			dispatchEvent(referencetermEvent);
		}
		
	}

}