package com.invision.view 
{
	import com.invision.model.DataModel;
	import com.invision.view.windows.BaseWindow;
	import flash.events.Event;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Dean Biele
	 */
	public class FeedbackView extends BaseWindow 
	{
		private var _dataModel:DataModel;
		private var _currentXMLList:XMLList;
		
		public var link_txt:TextField;
		
		public function FeedbackView() 
		{
			alpha = 0;
			addEventListener(Event.ADDED_TO_STAGE, addStageHandler, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedStageHandler, false, 0, true);
		}
		
		private function onRemovedStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedStageHandler);
			link_txt.removeEventListener(Event.CHANGE, onLinkUpdate);
		}
		
		private function addStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addStageHandler);
			x = 285;
			y = 50;
			addValuesFields();
			addTextFieldEventListeners();
			fadeIn();
		}
		
		private function addTextFieldEventListeners():void 
		{
			link_txt.addEventListener(Event.CHANGE, onLinkUpdate, false, 0, true);
		}
		
		private function onLinkUpdate(e:Event):void 
		{
			var currentTextField:TextField = e.currentTarget as TextField;
			_currentXMLList.link.@["urlid"] = currentTextField.text;
		}
		
		public function intialize(dataModel:DataModel) {
			_dataModel = dataModel;
			_currentXMLList = _dataModel.feedbackWindowXML;
		}
		
		private function addValuesFields():void 
		{
			link_txt.htmlText = _currentXMLList.link.@["urlid"];
		}
		
	}

}