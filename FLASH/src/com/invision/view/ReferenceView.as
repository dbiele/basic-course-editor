package com.invision.view 
{
	import com.invision.client.components.BasicButton;
	import com.invision.events.ReferenceTermEvent;
	import com.invision.model.DataModel;
	import com.invision.view.windows.BaseWindow;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	
	/**
	 * ...
	 * @author Dean Biele
	 */
	public class ReferenceView extends BaseWindow 
	{
		private var _addBasicButton:MovieClip;
		private var _scrollDownButton:MovieClip;
		private var _scrollUpButton:MovieClip;
		private var _currentXMLList:XMLList;
		private var _detailWindow:ReferenceTermWindow;
		private var _dataModel:DataModel;
		
		public function ReferenceView() 
		{
			alpha = 0;
			addEventListener(Event.ADDED_TO_STAGE, addStageHandler, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedStageHandler, false, 0, true);
		}
		
		private function onRemovedStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedStageHandler);
		}
		
		public function intialize(dataModel:DataModel) {
			trace("intialize");
			_dataModel = dataModel;
			_currentXMLList = _dataModel.referenceXML;
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
			
			var term:XML = <item/>; 
			term.@["link"] = "media/";
			term.@["icon"] = "media/";
			term.setChildren(XML("<![CDATA[New Reference Link]]>"));
			_currentXMLList.* += term;
			
			addDetailWindow();
			createLinks();
			var termXMLList:XMLList = _currentXMLList.item.(@link == term.@["link"]);
			_detailWindow.setXML(termXMLList);
		}		
		
		private function updateInstructionText():void 
		{
			instructions_txt.text = "Click Links Below: Total " + _currentXMLList.item.length();
		}
		
		private function addDetailWindow():void 
		{
			if (_detailWindow == null) {
				_detailWindow = new reference_term();
				_detailWindow.x = 216;
				_detailWindow.y = 83;
				addChild(_detailWindow);
				_detailWindow.addEventListener(ReferenceTermEvent.DELETE, onDeleteTermHandler, false, 0, true);
				_detailWindow.addEventListener(ReferenceTermEvent.UPDATE, onUpdateTermHandler, false, 0, true);
			}
		}
		
		private function createLinks():void 
		{
			trace("createLinks");
			glossaryterms.text = "";
			for each(var item in _currentXMLList.item) {
				addResponseItem(item);
			}
			glossaryterms.addEventListener(TextEvent.LINK, onLinkHandler, false, 0, true);
			updateInstructionText();
		}
		
		private function addResponseItem(currentXML:XML):void {
			trace("currentXML = " + currentXML.toXMLString());
			var item:String = "<a href=\'event:"+currentXML.@["link"]+"\'>"+currentXML.@["link"]+"</a><br>";
			glossaryterms.htmlText += item;
		}
		
		private function onLinkHandler(e:TextEvent):void 
		{
			trace("linkEvent.text = " + _detailWindow);
			addDetailWindow();
			var linkID:String = e.text;
			var termXMLList:XMLList = _currentXMLList.item.(@link == e.text);
			_detailWindow.setXML(termXMLList);
		}
		
		private function onDeleteTermHandler(e:ReferenceTermEvent):void 
		{
			trace("onDeleteTermHandler" + e.selectedID);
			while(_currentXMLList..item.(@link == e.selectedID).length() > 0){
				delete _currentXMLList..item.(@link == e.selectedID)[0];
			}
			removeChild(_detailWindow);
			_detailWindow = null;
			createLinks();
		}
		
		private function onUpdateTermHandler(e:ReferenceTermEvent):void 
		{
			trace("onUpdateTermHandler");
			createLinks();
		}
		
	}

}