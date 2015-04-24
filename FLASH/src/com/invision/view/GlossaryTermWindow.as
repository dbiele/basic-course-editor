package com.invision.view 
{
	import com.invision.client.components.BasicButton;
	import com.invision.events.GlossaryTermEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Dean Biele
	 */
	public class GlossaryTermWindow extends MovieClip 
	{
		public var delete_btn:MovieClip;
		public var term_txt:TextField;
		//public var link_txt:TextField;
		public var description_txt:TextField;
		
		private var _deleteBasicButton:BasicButton;
		private var _xmlList:XMLList;
		
		private var _selectedID:String
		
		public function GlossaryTermWindow() 
		{
			_deleteBasicButton = new BasicButton("delete", delete_btn);
			_deleteBasicButton.addEventListener(MouseEvent.MOUSE_UP, onDeleteHandler, false, 0, true);
		}
		
		public function setXML(xmlList:XMLList):void {
			_xmlList = xmlList;
			term_txt.text = _xmlList.@["name"];
			//link_txt.text = _xmlList.@["image"];
			_selectedID = _xmlList.@["id"];
			description_txt.text = _xmlList.toString();
			
			term_txt.addEventListener(Event.CHANGE, onTermChangeHandler, false, 0, true);
			//link_txt.addEventListener(Event.CHANGE, onLinkChangeHandler, false, 0, true);
			description_txt.addEventListener(Event.CHANGE, onDescriptionHandler, false, 0, true);
		}
		
		private function onTermChangeHandler(e:Event):void 
		{
			var currentText:TextField = e.currentTarget as TextField;
			_xmlList.@["name"] = currentText.text;
			var glossaryEvent:GlossaryTermEvent = new GlossaryTermEvent(GlossaryTermEvent.UPDATE);
			dispatchEvent(glossaryEvent);
		}
		
		private function onLinkChangeHandler(e:Event):void 
		{
			var currentText:TextField = e.currentTarget as TextField;
			_xmlList.@["image"] = currentText.text;
		}
		
		private function onDescriptionHandler(e:Event):void 
		{
			var currentText:TextField = e.currentTarget as TextField;
			_xmlList.setChildren(XML("<![CDATA["+currentText.text+"]]>"));
		}
		
		private function onDeleteHandler(e:MouseEvent):void 
		{
			var glossaryEvent:GlossaryTermEvent = new GlossaryTermEvent(GlossaryTermEvent.DELETE);
			glossaryEvent.selectedID = _selectedID;
			dispatchEvent(glossaryEvent);
		}
		
	}

}