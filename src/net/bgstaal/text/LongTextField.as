package net.bgstaal.text
{
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import no.bleed.text.ITextField;
	
	
	/**
	 * <b>LongText ©2009, bgstaal.net</b>
	 * <hr/>
	 * @author		Bjørn Gunnar Staal
	 * @version		1.0
	 */
	public class LongTextField extends Sprite
	{
		private const MAX_LINE_NUM:int = 300;
		
		private var _text:String;
		private var _htmlText:String;
		private var _isHtml:Boolean = false;
		private var _defaultTextFormat:TextFormat;
		private var _autoSize:String = TextFieldAutoSize.LEFT;
		private var _styleSheet:StyleSheet;
		private var _thickness:Number = 0;
		private var _sharpness:Number = 0;
		private var _textFields:Array;
		private var _width:Number = 100;
		private var _height:Number;
		private var _selectionStartField:TextField;
		private var _selectionStartIndex:int;
		
		public function set text (value:String):void
		{
			_text = value;
			_htmlText = null;
			_isHtml = false;
			update();
		}
		
		public function get text ():String
		{
			return _text;
		}
		
		public function set htmlText (value:String):void
		{
			_htmlText = value;
			_text = null;
			_isHtml = true;
			update();
		}
		
		public function get htmlText ():String
		{
			return _htmlText;
		}
		
		public function set defaultTextFormat (value:TextFormat):void
		{
			_defaultTextFormat = value;
			update();
		}
		
		public function set styleSheet (value:StyleSheet):void
		{
			_styleSheet = value;
			update();
		}
		
		public function set thickness (value:Number):void
		{
			_thickness = thickness;
			update();
		}
		
		public function get thickness ():Number
		{
			return _thickness;
		}
		
		public function set sharpness (value:Number):void
		{
			_sharpness = value;
			update();
		}
		
		public function get sharpness ():Number
		{
			return _sharpness;
		}
		
		public function get textHeight ():Number
		{
			var h:Number = 0;
			
			if (_textFields)
			{
				var t:TextField = _textFields[_textFields.length-1];
				if (t)
				{
					h = t.y + t.height;
				}
			}
				
			return h;
		}
		
		override public function set width (value:Number):void
		{
			_width = value;
			update();
		}
		
		
		override public function get width ():Number
		{
			return _width;
		}
		
		/**
		 *	Constructor
		 */
		public function LongTextField ()
		{
			super();
		}
		
		/**
		 * 
		 */
		private function update ():void
		{
			if (_text || _htmlText)
			{
				removeTextFields();
				addTextField(_isHtml ? _htmlText : _text);
			}
		}
		
		/**
		 *
		 */
		private function addTextField (text:String):void
		{
			// create new textField
			var textField:TextField = createTextField();
			setText(textField, text);
			
			// place textField below the previous field if it is not the first field
			if (_textFields.length > 0)
			{
				var prev:TextField = _textFields[_textFields.length-1];
				textField.y = prev.y + prev.textHeight - 1;
			}
			
			// add to displaylist and array
			addChild(textField);
			_textFields.push(textField);
			
			
			// check if the number of lines exceed the MAX_LINE_NUM property
			if (textField.numLines > MAX_LINE_NUM && _textFields.length < 4)
			{
				// get index of first char on line
				var index:int = textField.getLineOffset(MAX_LINE_NUM);
				
				// make shure to get the whole line of text if the field is html
				// since the getLineOffset wil not return the right number for this
				if (_isHtml)
				{
					var lineBeforeIndex:int = textField.getLineOffset(MAX_LINE_NUM-1);
					var lineBeforeLength:int = textField.getLineLength(MAX_LINE_NUM-1);
					var lineBeforeText:String = textField.text.substr(lineBeforeIndex, lineBeforeLength-1);
					index = text.indexOf(lineBeforeText, index) + lineBeforeLength-1;
				}
				
				var thisText:String = text.substr(0, index);
				var restText:String = text.substr(index);
				
				if (_isHtml)
				{
					// close open tag
					var pattern:RegExp = /<([a-z][a-z0-9]*)[^>]*(?<![\/])>[^<\/]*$/gi;
					thisText = thisText.replace(pattern, "$&</$1>");
					
					// remove closing tags at the beginning of the string
					pattern = /\A<(\/[a-å\s]*|[a-å\s]*\/)>/;
					while (restText.search(pattern) != -1)
					{
						restText = restText.replace(pattern, "");
					}
				}
				
				setText(textField, thisText);
				addTextField(restText);
			}
		}
		
		private function setText (textField:TextField, text:String):void
		{
			if (_isHtml)
			{
				textField.htmlText = text;
			}
			else
			{
				textField.text = text;
			}
		}
		
		/**
		 *
		 */
		private function createTextField ():TextField
		{
			var textField:TextField = new TextField();
			textField.width = _width;
			textField.embedFonts = true;
			textField.multiline = true;
			textField.wordWrap = true;
			textField.embedFonts = true;
			textField.autoSize = _autoSize;
			textField.thickness = _thickness;
			textField.sharpness = _sharpness;
			textField.antiAliasType = AntiAliasType.ADVANCED;
			//textField.selectable = false;
			textField.tabIndex = _textFields.length;
			if (_defaultTextFormat) textField.defaultTextFormat = _defaultTextFormat;
			if (_styleSheet) textField.styleSheet = _styleSheet;
			
			return textField;
		}
		
		private function removeTextFields ():void
		{
			if (_textFields)
			{
				for (var i:int = 0; i < _textFields.length; i++)
				{
					var tf:TextField = _textFields[i];
					if (tf.parent)
					{
						tf.parent.removeChild(tf);	
					}
				}
			}
			
			_textFields = [];
		}
		
	}
}