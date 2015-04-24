package com.invision.client.components {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Dean Biele
	 */
	public class BasicButton extends MovieClip {
		
        private var mType:String;
		private var mEnabled:Boolean;
		private var mCurrentMC:MovieClip;
		private var mCurrentID:String;	
		private var mState:String;
		private var mCurrentButtonMC:MovieClip;
		private var mToggle:Boolean = false;
		public static const CONTROL_TYPE_BUTTON_NORMAL:String = "normal";
		public static const CONTROL_TYPE_BUTTON_TOGGLE:String = "toggle";
		
		public function BasicButton(sID:String, currentMC:MovieClip, sType:String = "normal"):void {
			mCurrentID = sID;
			mCurrentMC = currentMC;
			mCurrentMC.gotoAndStop(1);
			mEnabled = true;
			if(mCurrentMC != null){
				if (mCurrentMC.hitarea_mc != null) {
					mCurrentButtonMC = mCurrentMC.hitarea_mc;
				}else {
					mCurrentButtonMC = mCurrentMC;
				}			
				setType(sType);
			}else {

			}
		}
		
        public function setType(sType:String):void {
            mType = sType;
			trace("setType = " + mType);
            switch (sType) {
                case CONTROL_TYPE_BUTTON_NORMAL:
                    buildNormalListener();
                    break;
                case CONTROL_TYPE_BUTTON_TOGGLE:
                    buildToggleListener();
                    break;
                default:
                    mType = CONTROL_TYPE_BUTTON_NORMAL;
                    buildNormalListener();
            }
        }
		
        public function getType():String {
            return mType;
        }
		
		private function onOverHandler(evt:MouseEvent):void {
			//trace("on onOverHandler2");
			if (mEnabled) {
				trace("on onOverHandler");
				var currentMC:MovieClip = evt.currentTarget as MovieClip;
				mCurrentMC.gotoAndPlay("Over");
				dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
			}
		}
		
		private function onOutHandler(evt:MouseEvent):void {
			if (mEnabled) {
				trace("on out");
				var currentMC:MovieClip = evt.currentTarget as MovieClip;
				mCurrentMC.gotoAndPlay("Out");
				dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT));
			}
		}
		
		private function onDownHandler(evt:MouseEvent):void {
			//trace("on down 22");
			if (mEnabled) {
				//trace("on down");
				var currentMC:MovieClip = evt.currentTarget as MovieClip;
				mCurrentMC.gotoAndPlay("Down");
				dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
			}
		}
		
		private function onUpHandler(evt:MouseEvent):void {
			trace("navbutton onUpHandler mEnabled = "+mEnabled);
			if (mEnabled) {
				//trace("on up");
				var currentMC:MovieClip = evt.currentTarget as MovieClip;
				dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP));
			}
		}		
		
		private function onOverToggleHandler(evt:MouseEvent):void {
			if (mEnabled) {
				//trace("on onOverToggleHandler");
				var currentMC:MovieClip = evt.currentTarget as MovieClip;
				if (!mToggle) {
					mCurrentMC.gotoAndPlay("Over");
				}
			}
		}
		
		private function onOutToggleHandler(evt:MouseEvent):void {
			//trace("onOutToggleHandler");
			if(mEnabled){
				var currentMC:MovieClip = evt.currentTarget as MovieClip;
				if (!mToggle) {
					mCurrentMC.gotoAndPlay("Out");
				}
			}
		}
		
		private function onDownToggleHandler(evt:MouseEvent):void {
			//trace("onDownToggleHandler");
			//trace("mEnabled = " + mEnabled);
			//trace("mToggle = " + mToggle);
			if(mEnabled){
				var currentMC:MovieClip = evt.currentTarget as MovieClip;
				if(!mToggle){
					mCurrentMC.gotoAndStop("Down");
					mToggle = true;
				}else {
					mCurrentMC.gotoAndPlay("Out");
					mToggle = false;
				}
				dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
			}
		}
		
		/*
		private function onOutToggleOutsideHandler(evt:MouseEvent):void {
			trace("onOutToggleOutsideHandler");
			if(mEnabled){
				var currentMC:MovieClip = evt.currentTarget as MovieClip;
				if (mToggle) {
					mCurrentMC.gotoAndPlay("Out");
					mToggle = false;
				}
			}
		}	
		*/
		
        public function getToggleState():Boolean {
            if (getType() == CONTROL_TYPE_BUTTON_TOGGLE) {
                return mToggle;
            } else {
                return false;
            }
        }
		
		public function getID():String { return mCurrentID; }
		
		public function getMovieClip():MovieClip { return mCurrentMC; }
		
		public function setState(s:String):void { mState = s;}
		public function getState():String { return mState; }
		public function isEnabled():Boolean { return mEnabled; }
		
		public function setDisabled():void {
			mEnabled = false;
			mCurrentButtonMC.buttonMode = false;
			mCurrentButtonMC.useHandCursor = false;
			mCurrentButtonMC.removeEventListener(MouseEvent.ROLL_OVER, onOverHandler);
			mCurrentButtonMC.removeEventListener(MouseEvent.ROLL_OUT, onOutHandler);
			mCurrentButtonMC.removeEventListener(MouseEvent.MOUSE_DOWN, onDownHandler);
			mCurrentButtonMC.removeEventListener(MouseEvent.MOUSE_UP, onUpHandler);	
			mCurrentButtonMC.gotoAndStop("Inactive");
		}
		
		public function setEnabled():void {
			setType(mType);
		}
		
        private function buildNormalListener():void {
			trace("buildNormalListener called");
			trace("mCurrentButtonMC = " + mCurrentButtonMC);
			mCurrentButtonMC.buttonMode = true;
			mCurrentButtonMC.useHandCursor = true;
			mCurrentButtonMC.addEventListener(MouseEvent.ROLL_OVER, onOverHandler, false, 0, true);
			mCurrentButtonMC.addEventListener(MouseEvent.ROLL_OUT, onOutHandler, false, 0, true);
			mCurrentButtonMC.addEventListener(MouseEvent.MOUSE_DOWN, onDownHandler, false, 0, true);
			mCurrentButtonMC.addEventListener(MouseEvent.MOUSE_UP, onUpHandler, false, 0, true);				
        }
		
        private function buildToggleListener():void {
			trace("buildToggleListener called");
			mCurrentButtonMC.buttonMode = true;
			mCurrentButtonMC.useHandCursor = true;
			mCurrentButtonMC.addEventListener(MouseEvent.ROLL_OVER, onOverToggleHandler, false, 0, true);
			mCurrentButtonMC.addEventListener(MouseEvent.ROLL_OUT, onOutToggleHandler, false, 0, true);
			mCurrentButtonMC.addEventListener(MouseEvent.MOUSE_DOWN, onDownToggleHandler, false, 0, true);
			mCurrentButtonMC.addEventListener(MouseEvent.MOUSE_UP, onUpHandler, false, 0, true);				
        }  	
		
		public function clearMemory():void {
			removeAllEventListeners();
		}
		
		private function removeNormalListeners():void {
			mCurrentButtonMC.removeEventListener(MouseEvent.ROLL_OVER, onOverHandler);
			mCurrentButtonMC.removeEventListener(MouseEvent.ROLL_OUT, onOutHandler);
			mCurrentButtonMC.removeEventListener(MouseEvent.MOUSE_DOWN, onDownHandler);
			mCurrentButtonMC.removeEventListener(MouseEvent.MOUSE_UP, onUpHandler);			
		}
		
		private function removeToggleListeners():void {
			mCurrentButtonMC.removeEventListener(MouseEvent.ROLL_OVER, onOverToggleHandler);
			mCurrentButtonMC.removeEventListener(MouseEvent.ROLL_OUT, onOutToggleHandler);
			mCurrentButtonMC.removeEventListener(MouseEvent.MOUSE_DOWN, onDownToggleHandler);
			mCurrentButtonMC.removeEventListener(MouseEvent.MOUSE_UP, onUpHandler);
		}
		
		
		public function removeAllEventListeners():void {
            switch (mType) {
                case CONTROL_TYPE_BUTTON_NORMAL:
					removeNormalListeners();
					break;
				case CONTROL_TYPE_BUTTON_TOGGLE:
                    removeToggleListeners();
                    break;
			}
		}
	}
	
}