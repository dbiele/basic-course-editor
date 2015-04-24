package com.invision.view 
{
	import com.invision.client.components.BasicButton;
	import com.invision.events.LessonTermEvent;
	import com.invision.events.ReferenceTermEvent;
	import com.invision.events.SceneTermEvent;
	import com.invision.model.DataModel;
	import com.invision.view.windows.BaseWindow;
	import com.invision.view.windows.SceneWindow;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	
	/**
	 * ...
	 * @author Dean Biele
	 */
	public class SceneView extends BaseWindow 
	{
		private var _addBasicButton:MovieClip;
		private var _scrollDownButton:MovieClip;
		private var _scrollUpButton:MovieClip;
		private var _currentSequenceXMLList:XMLList;
		private var _currentSceneXMLList:XMLList;
		private var _detailWindow:SceneWindow;
		private var _scenedetailWindow:SceneWindow;
		private var _dataModel:DataModel;
		private var _windowType:int = 0;
		
		public function SceneView() 
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
			_currentSequenceXMLList = _dataModel.sequenceXML;
			_currentSceneXMLList = _dataModel.scenesXML;
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
		
		private function updateInstructionText():void 
		{
			instructions_txt.text = "Click Links Below: Total " + _currentSequenceXMLList.step.length();
		}
		
		private function addLessonWindow():void 
		{
			if (_scenedetailWindow != null) {
				removeChild(_scenedetailWindow);
				_scenedetailWindow = null;
			}
			if (_detailWindow == null) {
				_detailWindow = new lesson_term();
				_detailWindow.x = 216;
				_detailWindow.y = 83;
				addChild(_detailWindow);
				_detailWindow.addEventListener(LessonTermEvent.UPDATE, onUpdateLessonHandler, false, 0, true);
			}
		}
		
		private function addSceneWindow():void 
		{
			if (_detailWindow != null) {
				removeChild(_detailWindow);
				_detailWindow = null;
			}
			if (_scenedetailWindow == null) {
				_scenedetailWindow = new scene_term();
				_scenedetailWindow.x = 216;
				_scenedetailWindow.y = 83;
				addChild(_scenedetailWindow);
				_scenedetailWindow.addEventListener(SceneTermEvent.UPDATE, onUpdateSceneHandler, false, 0, true);
			}
		}
		
		private function onUpdateSceneHandler(e:ReferenceTermEvent):void 
		{
			
		}
		
		private function createLinks():void 
		{
			glossaryterms.text = "";
			for each(var item in _currentSequenceXMLList.step) {
				addLessonItem(item);
				for each(var scene in item.step) {
					addSceneItem(scene);
				}
			}
			glossaryterms.addEventListener(TextEvent.LINK, onLinkHandler, false, 0, true);
			updateInstructionText();
		}
		
		private function addLessonItem(currentXML:XML):void {
			trace("currentXML = " + currentXML.toXMLString());
			var item:String = "<a href=\'event:"+currentXML.@["id"]+"\'><u>"+currentXML.@["name"]+"</u></a><br>";
			glossaryterms.htmlText += item;
		}
		
		private function addSceneItem(currentXML:XML):void {
			trace("currentXML = " + currentXML.toXMLString());
			var item:String = "<a href=\'event:sceneid="+currentXML.@["id"]+"\'><b>"+currentXML.@["id"]+"</b></a><br>";
			glossaryterms.htmlText += item;
		}
		
		private function onLinkHandler(e:TextEvent):void 
		{
			var termXMLList:XMLList
			var indexNum:int = e.text.indexOf("sceneid=");
			if (indexNum != -1) {
				addSceneWindow();
				termXMLList = _currentSceneXMLList.scene.(@id == e.text.substring(8));
				_scenedetailWindow.setXML(termXMLList);
			}else {
				addLessonWindow();
				termXMLList = _currentSequenceXMLList.step.(@id == e.text);
				_detailWindow.setXML(termXMLList);
			}
		}
		
		private function onUpdateLessonHandler(e:LessonTermEvent):void 
		{
			trace("onUpdateTermHandler");
			createLinks();
		}
		
	}

}