package net.bgstaal.color
{
	public class RGBColor
	{
		public var r:Number;
		public var g:Number;
		public var b:Number;
		
		public function get luminance ():Number
		{
			return getLuminance();
		}
		
		public function set luminance (value:Number):void
		{
			setLuminance(value);
		}
		
		public function get hex ():Number
		{
			return RGBColor.getHexFromRGB(r, g, b);
		}
		
		public function RGBColor(r:Number = 0, g:Number = 0, b:Number = 0)
		{
			this.r = r;
			this.g = g;
			this.b = b;
		}
		
		public function toString():String
		{
			return "r: " + r + " g: " + g + " b: " + b;
		}
		
		public static function getHexFromRGB(r:int, g:int, b:int):Number 
		{
		    return(r<<16 | g<<8 | b);
		}
		
		public static function getRGBfromHex (hex:Number):RGBColor
		{
		    var red:Number = hex>>16;
		    var greenBlue:Number = hex-(red<<16)
		    var green:Number = greenBlue>>8;
		    var blue:Number = greenBlue - (green << 8);
		    
		    return(new RGBColor(red, green, blue));
		}
		
		public function getLuminance ():Number
		{
			var average:Number = (r + b + g)/3;
			var luminocity:Number = average / 255;
			return luminocity; 
		}
		
		public function setLuminance (value:Number):void
		{
			var current:Number = getLuminance();
			var difference:Number = value - current;
			var step:Number = (difference/3)*255;
			r += step;
			g += step;
			b += step;
			
			if (r <0)
				r = 0;
			if (g < 0)
				g = 0;
			if (b < 0)
				b = 0;
			if (r > 255)
				r = 255;
			if (g > 255)
				g = 255;
			if (b > 255)
				b = 255;
		}
		
		public function getCopy ():RGBColor
		{
			return new RGBColor(r, g, b);
		}

	}
}