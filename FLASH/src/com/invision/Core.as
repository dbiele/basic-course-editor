package com.invision 
{
	import com.greensock.easing.Back;
	import com.greensock.TweenLite;
	import com.invision.events.BrowseEvent;
	import com.invision.events.DataModelEvent;
	import com.invision.events.NavigationEvent;
	import com.invision.model.DataModel;
	import com.invision.services.XMLData;
	import com.invision.view.BrowseView;
	import com.invision.view.FeedbackView;
	import com.invision.view.GeneralDataView;
	import com.invision.view.GlossaryView;
	import com.invision.view.NavigationView;
	import com.invision.view.ReferenceView;
	import com.invision.view.SaveView;
	import com.invision.view.SceneView;
	import com.invision.view.windows.BaseWindow;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Dean Biele
	 */
	public class Core extends MovieClip 
	{
		public var navWindow:NavigationView;
		
		private var _browseView:BrowseView;
		private var _currentSelectedView:BaseWindow;
		private var _dataModel:DataModel;
		private var _generalDataView:GeneralDataView;
		private var _saveView:SaveView;
		private var _feedbackView:FeedbackView;
		private var _glossaryView:GlossaryView;
		private var _referenceView:ReferenceView;
		private var _sceneWindow:SceneView;
		
		public function Core() 
		{
			if (stage) {
				initialize();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, initialize, false, 0, true);
			}
		}
		
		private function initialize(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			_dataModel = new DataModel();
			navWindow.addEventListener(NavigationEvent.SELECTED, onCategorySelected, false, 0, true);
			showBrowseDialog();
		}
		
		public function onCategorySelected(e:NavigationEvent):void 
		{
			trace("get item selected = " + navWindow.getSelectedItem());

			removeActiveContentWindow();
			switch(navWindow.getSelectedItem()) {
				case 0:
					showGeneralDataDialog();
					break;
				case 1:
					showFeedbackWindow();
					break;
				case 2:
					showGlossaryWindow();
					break;
				case 3:
					showReferenceWindow();
					break;
				case 4:
					showSceneWindow();
					break;
				case 5:
					showSaveDialog();
					break;
			}

		}
		
		private function showSceneWindow():void 
		{
			_sceneWindow = new SceneView();
			_currentSelectedView = _sceneWindow;
			_sceneWindow.intialize(_dataModel);
			addChild(_sceneWindow);	
		}
		
		private function showReferenceWindow():void 
		{
			trace("showReferenceWindow");
			_referenceView = new ReferenceView();
			_currentSelectedView = _referenceView;
			_referenceView.intialize(_dataModel);
			addChild(_referenceView);
		}
		
		private function showGlossaryWindow():void 
		{
			trace("showGlossaryWindow");
			_glossaryView = new GlossaryView();
			_currentSelectedView = _glossaryView;
			_glossaryView.intialize(_dataModel);
			addChild(_glossaryView);		
		}
		
		private function showFeedbackWindow():void 
		{
			_feedbackView = new FeedbackView();
			_currentSelectedView = _feedbackView;
			_feedbackView.intialize(_dataModel);
			addChild(_feedbackView);
		}
		
		private function showSaveDialog():void 
		{
			_saveView = new SaveView();
			_currentSelectedView = _saveView;
			_saveView.intialize(_dataModel);
			addChild(_saveView);
		}
		
		private function removeActiveContentWindow():void 
		{
			if(_currentSelectedView != null){
				_currentSelectedView.removeContentWindow();
			}
		}
		
		private function showGeneralDataDialog():void 
		{
			_generalDataView = new GeneralDataView();
			_currentSelectedView = _generalDataView;
			_generalDataView.intialize(_dataModel);
			addChild(_generalDataView);
		}
		
		public function showBrowseDialog() {
			_browseView = new BrowseView();
			_currentSelectedView = _browseView;
			_browseView.addEventListener(BrowseEvent.SELECTED, onBrowseSelected, false, 0, true);
			addChild(_browseView);
		}
		
		public function removeBrowseDialog() {
			_browseView.removeEventListener(BrowseEvent.SELECTED, onBrowseSelected);
			removeChild(_browseView);
		}
		
		private function onBrowseSelected(e:Event):void 
		{
			_dataModel.BrowseFile();
			_dataModel.addEventListener(DataModelEvent.SELECTED, onDataReturned, false, 0, true);
		}
		
		private function onDataReturned(e:DataModelEvent):void 
		{
			trace("on data returned");
			_browseView.setLoadedFileName(_dataModel.getFileName());
			navWindow.activate();
			_currentSelectedView = null;
			TweenLite.to(_browseView, 0.5, { y: -300, onComplete:removeBrowseDialog,ease:Back.easeIn } );
			//removeBrowseDialog();
		}
	}

}