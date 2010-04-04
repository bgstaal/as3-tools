package net.bgstaal.utils
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	public class FPSMeter extends Sprite
	{
		private var _font:String;
		private var _size:Number;
		private var _color:Number;
		private var _field:TextField;
		private var _time:Number = getTimer();
		
		public function FPSMeter(size:Number = 16, font:String = "Courier New", color:Number = 0xFFFF00)
		{
			_font = font;
			_size = size;
			_color = color;
			init();
		}
		
		private function init ():void
		{
			createField();
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		private function createField ():void
		{
			var format:TextFormat = new TextFormat();
			format.font = _font;
			format.color = _color;
			format.size = _size;
			
			_field = new TextField();
			_field.defaultTextFormat = format;
			_field.autoSize = TextFieldAutoSize.LEFT;
			_field.text = "fps: 0";
			
			addChild(_field);
		}
		
		private function addedToStageHandler (e:Event):void
		{
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function removedFromStageHandler (e:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function enterFrameHandler (e:Event):void
		{
			var time:Number = getTimer();
			var frameTime:Number = time-_time;
			var fps:Number = 1000/frameTime;
			fps = Math.round(fps*100)/100;
			_field.text = "fps: " + fps;
			
			_time = time;
		}

	}
}