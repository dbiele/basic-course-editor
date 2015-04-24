package com.invision.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Dean Biele
	 */
	public class DataModelEvent extends Event 
	{
		static public const SELECTED:String = "selected";
		
		public function DataModelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
        override public function clone():Event
        {
            return new DataModelEvent(type, bubbles, cancelable);
        }
		
	}

}