package com.invision.view 
{
	import com.invision.client.components.BasicButton;
	import com.invision.events.GlossaryTermEvent;
	import com.invision.events.ReferenceTermEvent;
	import com.invision.events.SceneTermEvent;
	import com.invision.view.windows.SceneWindow;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Dean Biele
	 */
	public class SceneTermWindow extends SceneWindow 
	{
		public var name_txt:TextField;
		public var audio_txt:TextField;
		public var caption_background:Sprite;
		public var scrollup_btn:MovieClip;
		public var scrolldown_btn:MovieClip;
		public var blank_mc:MovieClip;
		
		private var _xmlList:XMLList;
		
		private var _selectedID:String;
		
		private var captionMC:MovieClip;
		
		public function SceneTermWindow() 
		{
		}
		
		override public function setXML(xmlList:XMLList):void {
			_xmlList = xmlList;
			name_txt.text = _xmlList.@["id"];
			audio_txt.text = _xmlList.audio.audiofile.@["audio"];
			audio_txt.addEventListener(Event.CHANGE, onAudioChangeHandler, false, 0, true);
			
			addButtonHandlers();
			
			if (captionMC != null) {
				blank_mc.removeChild(captionMC);
				captionMC = null;
			}
			
			captionMC = new MovieClip();
			captionMC.x = 0;
			captionMC.y = 0;
			blank_mc.addChild(captionMC);
			var totalItems:int = 0;
			for each(var caption in _xmlList.captioning.children()) {
				addCaptionItem(caption, totalItems);
				totalItems++;
			}
			caption_background.height = 100 + (totalItems * 90);
			if (captionMC.height > 370) {
				scrollup_btn.visible = true;
				scrolldown_btn.visible = true;
			}else {
				scrollup_btn.visible = false;
				scrolldown_btn.visible = false;
			}
		}
		
		private function addButtonHandlers():void 
		{
			scrollup_btn.buttonMode = true;
			scrollup_btn.useHandCursor = true;
			scrollup_btn.addEventListener(MouseEvent.MOUSE_UP, onScrollUpHandler, false, 0, true);
			
			scrolldown_btn.buttonMode = true;
			scrolldown_btn.useHandCursor = true;
			scrolldown_btn.addEventListener(MouseEvent.MOUSE_UP, onScrollDownHandler, false, 0, true);
		}
		
		private function onScrollDownHandler(e:MouseEvent):void 
		{
			if(captionMC.height >370){
				captionMC.y += 40;
			}
		}
		
		private function onScrollUpHandler(e:MouseEvent):void 
		{
			if(captionMC.height >370){
				captionMC.y -= 40;
			}
		}
		
		private function addCaptionItem(currentXML:XML, totalItems:int):void {
			var captionItem:CaptionItemView = new caption_item();
			captionItem.setXML(currentXML);
			captionItem.x = 0;
			captionItem.y = (totalItems * captionItem.height)+5;
			captionMC.addChild(captionItem);
		}
		
		private function onAudioChangeHandler(e:Event):void 
		{
			var currentText:TextField = e.currentTarget as TextField;
			_xmlList.audio.@["audio"] = currentText.text;
			
			var referencetermEvent:SceneTermEvent = new SceneTermEvent(SceneTermEvent.UPDATE);
			dispatchEvent(referencetermEvent);
		}
		
	}

}