package com.invision.model 
{
	import com.invision.events.DataModelEvent;
	import com.invision.services.XMLData;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Dean Biele
	 */
	public class DataModel extends EventDispatcher 
	{
		private var _xmlData:XMLData;
		private var _fileReference:FileReference;
		private var _data:XML;
		
		public function DataModel() 
		{
			_xmlData = new XMLData();
		}
		
		public function BrowseFile():void 
		{
			_fileReference = _xmlData.BrowseXMLFile();
			_fileReference.addEventListener(Event.COMPLETE, xmlCompleteHandler, false, 0, true);
		}
		
		public function getFileName():String {
			return _fileReference.name;
		}
		
		public function getXMLData():XML {
			return _data;
		}
		
		public function isXMLSelected():Boolean 
		{
			return (_data != null) ? true : false;
		}
		
		public function saveXML():void 
		{
			_xmlData.SaveXMLFile(_data);
		}
		
		public function get sequenceXML():XMLList 
		{
			return _data.sequences;
		}
		
		public function get scenesXML():XMLList 
		{
			return _data.scenes;
		}
		
		public function get referenceXML():XMLList 
		{
			return _data.jobaids;
		}
				
		
		public function get glossaryXML():XMLList 
		{
			return _data.glossary;
		}
		
		public function get feedbackWindowXML():XMLList 
		{
			return _data.feedbackwindow;
		}
		
		public function get administrationXML():XMLList {
			return _data.administration;
		}
		
		private function xmlCompleteHandler(evt:Event):void 
		{
			trace("load complete" + _fileReference.name);
			_fileReference.removeEventListener(Event.COMPLETE, xmlCompleteHandler);
			var data:* = FileReference(evt.target).data;
			if (data is ByteArray)
			{
				try
				{
					ByteArray(data).uncompress();
				}
				catch(e:Error)
				{
				}
 
			}
			_data = XML(data);
			dispatchEvent(new DataModelEvent(DataModelEvent.SELECTED));
		}
		
	}

}