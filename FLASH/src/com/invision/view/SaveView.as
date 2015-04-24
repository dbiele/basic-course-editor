package com.invision.view 
{
	import com.invision.client.components.BasicButton;
	import com.invision.model.DataModel;
	import com.invision.view.windows.BaseWindow;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Dean Biele
	 */
	public class SaveView extends BaseWindow 
	{
		private var _saveBasicButton:BasicButton;
		private var _dataModel:DataModel;
		
		public var save_btn:MovieClip;
		
		public function SaveView() 
		{
			super();
			x = 380;
			y = 300;
			_saveBasicButton = new BasicButton("save", save_btn);
			_saveBasicButton.addEventListener(MouseEvent.MOUSE_UP, onSaveUpHandler, false, 0, true);
		}
		
		public function intialize(dataModel:DataModel) {
			_dataModel = dataModel;
		}
		
		private function onSaveUpHandler(e:MouseEvent):void 
		{
			_dataModel.saveXML();
		}
		
	}

}