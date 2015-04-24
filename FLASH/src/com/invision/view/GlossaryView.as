package com.invision.view 
{
	import com.invision.client.components.BasicButton;
	import com.invision.events.GlossaryTermEvent;
	import com.invision.model.DataModel;
	import com.invision.view.windows.BaseWindow;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Dean Biele
	 */
	public class GlossaryView extends BaseWindow 
	{
		public var glossaryterms:TextField;
		public var add_btn:MovieClip;
		public var scrolldown_btn:MovieClip;
		public var scrollup_btn:MovieClip;
		public var instructions_txt:TextField;
		
		private var _dataModel:DataModel;
		private var _currentXMLList:XMLList;
		private var _detailWindow:GlossaryTermWindow;
		private var _addBasicButton:BasicButton;
		private var _scrollDownButton:BasicButton;
		private var _scrollUpButton:BasicButton;
		
		public function GlossaryView() 
		{
			alpha = 0;
			addEventListener(Event.ADDED_TO_STAGE, addStageHandler, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedStageHandler, false, 0, true);
		}
		
		private function onRemovedStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedStageHandler);
		}
		
		private function addStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addStageHandler);
			x = 285;
			y = 50;
			addHandler();
			createLinks();
			fadeIn();
		}
		
		private function updateInstructionText():void 
		{
			instructions_txt.text = "Click Links Below: Total " + _currentXMLList.term.length();
		}
		
		private function addHandler():void 
		{
			_addBasicButton = new BasicButton("addterm", add_btn);
			_addBasicButton.addEventListener(MouseEvent.MOUSE_UP, onAddHandler, false, 0, true);
			
			_scrollDownButton = new BasicButton("scrollDown", scrolldown_btn);
			_scrollDownButton.addEventListener(MouseEvent.MOUSE_UP, onScrollDownHandler, false, 0, true);
			
			_scrollUpButton = new BasicButton("scrollup", scrollup_btn);
			_scrollUpButton.addEventListener(MouseEvent.MOUSE_UP, onScrollUpHandler, false, 0, true);
		}
		
		private function onScrollUpHandler(e:MouseEvent):void 
		{
			glossaryterms.scrollV++;
		}
		
		private function onScrollDownHandler(e:MouseEvent):void 
		{
			glossaryterms.scrollV--;
		}
		
		private function onAddHandler(e:MouseEvent):void {
			
			//var nodeName:String = "term";
			//var newTerm:XML = <{nodeName}>{}</{nodeName}>;
			
			var term:XML = <term/>; 
			term.@["image"] = "default";
			term.@["name"] = "New Term";
			term.@["id"] = "item"+Math.floor((Math.random()*100000));
			term.setChildren(XML("<![CDATA[]]>"));
			_currentXMLList.* += term;
			
			addDetailWindow();
			createLinks();
			var termXMLList:XMLList = _currentXMLList.term.(@id == term.@["id"]);
			_detailWindow.setXML(termXMLList);
		}
		
		private function createLinks():void 
		{
			glossaryterms.text = "";
			for each(var item in _currentXMLList.term) {
				addResponseItem(item);
			}
			glossaryterms.addEventListener(TextEvent.LINK, onLinkHandler, false, 0, true);
			updateInstructionText();
		}
		
		private function onLinkHandler(e:TextEvent):void 
		{
			trace("linkEvent.text = " + _detailWindow);
			addDetailWindow();
			var termID:String = e.text;
			var termXMLList:XMLList = _currentXMLList.term.(@id == e.text);
			_detailWindow.setXML(termXMLList);
		}
		
		private function addDetailWindow():void 
		{
			if (_detailWindow == null) {
				_detailWindow = new glossary_term();
				_detailWindow.x = 196;
				_detailWindow.y = 83;
				addChild(_detailWindow);
				_detailWindow.addEventListener(GlossaryTermEvent.DELETE, onDeleteTermHandler, false, 0, true);
				_detailWindow.addEventListener(GlossaryTermEvent.UPDATE, onUpdateTermHandler, false, 0, true);
			}
		}
		
		private function onUpdateTermHandler(e:GlossaryTermEvent):void 
		{
			trace("onUpdateTermHandler");
			createLinks();
		}
		
		private function addResponseItem(currentXML:XML):void {
			
			var item:String = "<a href=\'event:"+currentXML.@["id"]+"\'>"+currentXML.@["name"]+"</a><br>";
			glossaryterms.htmlText += item;
		}
		
		public function intialize(dataModel:DataModel) {
			trace("intialize");
			_dataModel = dataModel;
			_currentXMLList = _dataModel.glossaryXML;
		}
		
		private function onDeleteTermHandler(e:GlossaryTermEvent):void 
		{
			trace("onDeleteTermHandler" + e.selectedID);
			while(_currentXMLList..term.(@id == e.selectedID).length() > 0){
				delete _currentXMLList..term.(@id == e.selectedID)[0];
			}
			removeChild(_detailWindow);
			_detailWindow = null;
			createLinks();
		}
		
	}

}