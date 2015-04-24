package com.invision.view 
{
	import com.greensock.TweenLite;
	import com.invision.events.NavigationEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Dean Biele
	 */
	public class NavigationView extends MovieClip 
	{
		
		public var gendata_icon:MovieClip;
		public var feedback_icon:MovieClip;
		public var glossary_icon:MovieClip;
		public var reference_icon:MovieClip;
		public var scenedata_icon:MovieClip;
		public var save_icon:MovieClip;
		
		private var _mcArray:Array;
		private var _selectionArray:Array;
		private var _itemSelected:int;
		
		public function NavigationView() {
			if (stage) {
				initialize();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, initialize, false, 0, true);
			}
		}
		
		public function getSelectedItem():int {
			for (var i:int = 0; i < _mcArray.length; i++) {
				if (_mcArray[i][0] == 1) {
					break;
				}
			}
			return i;
		}
		
		public function activate():void 
		{
			showAllSelectedIcons();
			addIconHandlers();
		}
		
		private function initialize(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			_mcArray = [[0,"gendata_icon"], [0,"feedback_icon"], [0,"glossary_icon"], [0,"reference_icon"], [0,"scenedata_icon"], [0,"save_icon"]];
			dimNoSelectedIcons();
		}
		
		private function addIconHandlers():void 
		{
			gendata_icon.buttonMode = true;
			gendata_icon.useHandCursor = true;
			gendata_icon.addEventListener(MouseEvent.MOUSE_DOWN, onGenDataUpHandler, false, 0, true);
			gendata_icon.addEventListener(MouseEvent.ROLL_OVER, onRollOverHandler, false, 0, true);
			gendata_icon.addEventListener(MouseEvent.ROLL_OUT, onRollOutHandler, false, 0, true);
			
			feedback_icon.buttonMode = true;
			feedback_icon.useHandCursor = true;
			feedback_icon.addEventListener(MouseEvent.MOUSE_DOWN, onFeedbackUpHandler, false, 0, true);
			feedback_icon.addEventListener(MouseEvent.ROLL_OVER, onRollOverHandler, false, 0, true);
			feedback_icon.addEventListener(MouseEvent.ROLL_OUT, onRollOutHandler, false, 0, true);
			
			glossary_icon.buttonMode = true;
			glossary_icon.useHandCursor = true;
			glossary_icon.addEventListener(MouseEvent.MOUSE_DOWN, onGlossaryUpHandler, false, 0, true);
			glossary_icon.addEventListener(MouseEvent.ROLL_OVER, onRollOverHandler, false, 0, true);
			glossary_icon.addEventListener(MouseEvent.ROLL_OUT, onRollOutHandler, false, 0, true);
			
			reference_icon.buttonMode = true;
			reference_icon.useHandCursor = true;
			reference_icon.addEventListener(MouseEvent.MOUSE_DOWN, onReferenceUpHandler, false, 0, true);
			reference_icon.addEventListener(MouseEvent.ROLL_OVER, onRollOverHandler, false, 0, true);
			reference_icon.addEventListener(MouseEvent.ROLL_OUT, onRollOutHandler, false, 0, true);
			
			scenedata_icon.buttonMode = true;
			scenedata_icon.useHandCursor = true;
			scenedata_icon.addEventListener(MouseEvent.MOUSE_DOWN, onSceneDataUpHandler, false, 0, true);
			scenedata_icon.addEventListener(MouseEvent.ROLL_OVER, onRollOverHandler, false, 0, true);
			scenedata_icon.addEventListener(MouseEvent.ROLL_OUT, onRollOutHandler, false, 0, true);
			
			save_icon.buttonMode = true;
			save_icon.useHandCursor = true;
			save_icon.addEventListener(MouseEvent.MOUSE_DOWN, onSaveUpHandler, false, 0, true);
			save_icon.addEventListener(MouseEvent.ROLL_OVER, onRollOverHandler, false, 0, true);
			save_icon.addEventListener(MouseEvent.ROLL_OUT, onRollOutHandler, false, 0, true);
			
		}
		
		private function onRollOverHandler(e:MouseEvent):void 
		{
			if(_itemSelected != 0){
				var currentTarget:MovieClip = e.currentTarget as MovieClip;
				var currentlyNotSelected:int = 0;
				for (var i:int = 0; i < _mcArray.length; i++) {
					if (_mcArray[i][1] == currentTarget.name) {
						if (_mcArray[i][0] != 1) {
							currentlyNotSelected = 1;
						}
					}
				}
				if (currentlyNotSelected == 1) {
					TweenLite.to(currentTarget, 0.5, { alpha:1 } );
				}
			}
		}
		
		private function onRollOutHandler(e:MouseEvent):void 
		{
			if(_itemSelected != 0){
				var currentTarget:MovieClip = e.currentTarget as MovieClip;
				var currentlyNotSelected:int = 0;
				for (var i:int = 0; i < _mcArray.length; i++) {
					if (_mcArray[i][1] == currentTarget.name) {
						if (_mcArray[i][0] != 1) {
							currentlyNotSelected = 1;
						}
					}
				}
				if (currentlyNotSelected == 1) {
					TweenLite.to(currentTarget, 0.5, { alpha:.45 } );
				}
			}
		}
		
		private function onSaveUpHandler(e:MouseEvent):void 
		{
			setActiveSection(e);
		}
		
		private function onSceneDataUpHandler(e:MouseEvent):void 
		{
			setActiveSection(e);
		}
		
		private function onReferenceUpHandler(e:MouseEvent):void 
		{
			setActiveSection(e);
		}
		
		private function onGlossaryUpHandler(e:MouseEvent):void 
		{
			setActiveSection(e);
		}
		
		private function onFeedbackUpHandler(e:MouseEvent):void 
		{
			setActiveSection(e);
		}
		
		private function onGenDataUpHandler(e:MouseEvent):void 
		{
			setActiveSection(e);
		}
		
		private function setActiveSection(e:MouseEvent):void 
		{
			var currentTarget:MovieClip = e.currentTarget as MovieClip;
			var currentlyNotSelected:int = 0;
			for (var i:int = 0; i < _mcArray.length; i++) {
				if (_mcArray[i][1] == currentTarget.name) {
					if (_mcArray[i][0] != 1) {
						// set the visibility to 1
						_mcArray[i][0] = 1;
						_itemSelected = i+1;
						currentlyNotSelected = 1;
						TweenLite.to(currentTarget, 0.5, { alpha:1 } );
					}
				}else {
					_mcArray[i][0] = 0;
				}
			}
			if (currentlyNotSelected == 1) {
				dimNoSelectedIcons();
				var navigationEvent:NavigationEvent = new NavigationEvent(NavigationEvent.SELECTED);
				dispatchEvent(navigationEvent);
			}
		}
		
		private function dimNoSelectedIcons() {
			var selectedMC:MovieClip;
			for (var i:int = 0; i < _mcArray.length; i++) {
				if (_mcArray[i][0] == 0) {
					selectedMC = this[_mcArray[i][1]] as MovieClip;
					TweenLite.to(selectedMC, 0.5, { alpha:.45 } );
				}
			}
		}
		
		private function showAllSelectedIcons() {
			var selectedMC:MovieClip;
			for (var i:int = 0; i < _mcArray.length; i++) {
				if (_mcArray[i][0] == 0) {
					selectedMC = this[_mcArray[i][1]] as MovieClip;
					TweenLite.to(selectedMC, 0.5, { alpha:1 } );
				}
			}
		}
		
	}

}