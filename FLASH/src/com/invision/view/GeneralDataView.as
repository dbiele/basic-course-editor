package com.invision.view 
{
	import com.invision.model.DataModel;
	import com.invision.view.windows.BaseWindow;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Dean Biele
	 */
	public class GeneralDataView extends BaseWindow 
	{
		public var coursetitle_txt:TextField;
		public var coursedate_txt:TextField;
		public var navigation_txt:TextField;
		public var autoscenecomplete_txt:TextField;
		public var author_txt:TextField;
		
		private var _dataModel:DataModel
		private var _administrationXML:XMLList;
		private var _currentXMLList:XMLList;
		
		public function GeneralDataView() 
		{
			alpha = 0;
			addEventListener(Event.ADDED_TO_STAGE, addStageHandler, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedStageHandler, false, 0, true);
		}
		
		private function onRemovedStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedStageHandler);
			coursetitle_txt.removeEventListener(Event.CHANGE, onCourseTitleUpdate);
			coursedate_txt.removeEventListener(Event.CHANGE, onCourseDateUpdate);
			navigation_txt.removeEventListener(Event.CHANGE, onCourseNavigationUpdate);
			autoscenecomplete_txt.removeEventListener(Event.CHANGE, onAutoSceneCompleteUpdate);
			author_txt.removeEventListener(Event.CHANGE, onAuthorUpdate);
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
			coursetitle_txt.addEventListener(Event.CHANGE, onCourseTitleUpdate, false, 0, true);
			coursedate_txt.addEventListener(Event.CHANGE, onCourseDateUpdate, false, 0, true);
			navigation_txt.addEventListener(Event.CHANGE, onCourseNavigationUpdate, false, 0, true);
			autoscenecomplete_txt.addEventListener(Event.CHANGE, onAutoSceneCompleteUpdate, false, 0, true);
			author_txt.addEventListener(Event.CHANGE, onAuthorUpdate, false, 0, true);
		}
		
		private function onCourseTitleUpdate(e:Event):void 
		{
			var currentTextField:TextField = e.currentTarget as TextField;
			_currentXMLList.admin.@["coursetitle"] = currentTextField.text;
		}
		
		private function onCourseDateUpdate(e:Event):void 
		{
			var currentTextField:TextField = e.currentTarget as TextField;
			_currentXMLList.admin.@["coursedate"] = currentTextField.text;
		}
		
		private function onCourseNavigationUpdate(e:Event):void 
		{
			var currentTextField:TextField = e.currentTarget as TextField;
			_currentXMLList.admin.@["navigation"] = currentTextField.text;
		}
		
		private function onAutoSceneCompleteUpdate(e:Event):void 
		{
			var currentTextField:TextField = e.currentTarget as TextField;
			_currentXMLList.admin.@["autoscenecomplete"] = currentTextField.text;
		}
		
		private function onAuthorUpdate(e:Event):void 
		{
			var currentTextField:TextField = e.currentTarget as TextField;
			_currentXMLList.admin.@["author"] = currentTextField.text;
		}
		
		private function addValuesFields():void 
		{
			coursetitle_txt.htmlText = _currentXMLList.admin.@["coursetitle"];
			coursedate_txt.text = _currentXMLList.admin.@["coursedate"]; 
			navigation_txt.text = _currentXMLList.admin.@["navigation"];
			autoscenecomplete_txt.text = _currentXMLList.admin.@["autoscenecomplete"];
			author_txt.text = _currentXMLList.admin.@["author"];
		}
		
		public function intialize(dataModel:DataModel) {
			_dataModel = dataModel;
			_currentXMLList = _dataModel.administrationXML;
		}
		
	}

}