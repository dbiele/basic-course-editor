package com.invision.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Dean Biele
	 */
	public class SceneTermEvent extends Event 
	{
		static public const UPDATE:String = "update";
		public var selectedID:String;
		
		public function SceneTermEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
		}
		
	}

}