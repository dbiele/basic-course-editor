package com.invision.view.windows 
{
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Dean Biele
	 */
	public class BaseWindow extends MovieClip 
	{
		
		public function BaseWindow() 
		{
			trace("window name = "+this.name);
		}
		
		public function removeContentWindow():void {
			TweenLite.to(this, 0.5, {alpha:0, onComplete:onTransitionOutComplete } );
		}
		
		private function onTransitionOutComplete():void {
			trace("onTransitionOutComplete "+this.name);
			
			parent.removeChild(this);
		}
		
		private function onTransitionInComplete():void {
			
		}
		
		protected function fadeIn():void {
			TweenLite.to(this, 0.5, {alpha:1, onComplete:onTransitionInComplete } );
		}	
		
	}

}