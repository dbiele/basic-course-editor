package com.invision.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Dean Biele
	 */
	public class ReferenceTermEvent extends Event 
	{
		static public const DELETE:String = "delete";
		static public const UPDATE:String = "update";
		public var selectedID:String;
		
		public function ReferenceTermEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
		}
		
	}

}