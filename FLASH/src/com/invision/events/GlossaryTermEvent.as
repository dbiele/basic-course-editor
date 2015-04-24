package com.invision.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Dean Biele
	 */
	public class GlossaryTermEvent extends Event 
	{
		static public const DELETE:String = "delete";
		static public const UPDATE:String = "update";
		public var selectedID:String;
		
		public function GlossaryTermEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
		}
		
	}

}