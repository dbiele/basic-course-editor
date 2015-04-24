package com.invision.services 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Dean Biele
	 */
	public class XMLData extends EventDispatcher 
	{
		private var _xmlFile:FileReference;
		
		public function XMLData() 
		{
			
		}
		
		public function BrowseXMLFile():FileReference {
			_xmlFile = new FileReference();
			_xmlFile.addEventListener(Event.SELECT, xmlSelectHandler, false, 0, true);
			_xmlFile.browse([new FileFilter("XML Documents", "*.xml")]);
			return _xmlFile;
		}
		
		public function SaveXMLFile(xmlFile:XML):void {
			// saves file as binary
			var data:ByteArray = new ByteArray();
			data.writeUTFBytes(xmlFile);
			//data.compress();
			new FileReference().save(data, _xmlFile.name);

		}
		
		private function xmlSelectHandler(e:Event):void 
		{
			trace("xmlSelectHandler");
			_xmlFile.removeEventListener(Event.SELECT, xmlSelectHandler);
			//_xmlFile.addEventListener(Event.COMPLETE, xmlComplete, false, 0, true);
			_xmlFile.load();
		}

		
	}

}