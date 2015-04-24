package com.invision.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Dean Biele
	 */
	public class NavigationEvent extends Event 
	{
		static public const SELECTED:String = "selected";
		
		public function NavigationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}		
		
        override public function clone():Event
        {
            return new NavigationEvent(type, bubbles, cancelable);
        }		
	}

}