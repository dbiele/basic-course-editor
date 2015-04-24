package com.invision.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Dean Biele
	 */
	public class LessonTermEvent extends Event 
	{
		static public const UPDATE:String = "update";
		public var selectedID:String;
		
		public function LessonTermEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
		}
		
	}

}