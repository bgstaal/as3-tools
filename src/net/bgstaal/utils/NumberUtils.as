package net.bgstaal.utils
{
	public class NumberUtils
	{
		
		public static function round(number:Number, numDecimals:Number):Number
		{
			var multiplier:int = Math.pow(10, numDecimals);
			var value:Number = int((number)*multiplier)/multiplier;
			
			return value;
		}
		
		public static function intToString (num:int, cyphers:int = 2):String
		{
			var s:String = num.toString();
			var difference:int = cyphers - s.length;
			
			for (var i:int = 0; i<difference; i++)
			{
				s = "0" + s;
			}
			
			return s;
		}
		
		public static function currencyFormat (number:Number, numDecimals:int = 2, separatorSymbol:String = ",", decimalSymbol:String = "."):String
		{
			var multiplier:int = Math.pow(10, numDecimals);
			number = Math.round(number*multiplier)/multiplier;
			number = round(number, numDecimals);
			var string:String = number.toString();
			
			var split:Array = string.split(".");
			var pre:String = split[0];
			var post:String = split[1] == null ? "" : split[1];
			
			
			// Format Number
			
			var _pre:String = pre.slice();
			pre = "";
			
			var count:int = 0;
			var i:int;
			for (i = _pre.length; i >= 0; i--)
			{
				var cypher:String = _pre.charAt(i);
				
				if (count % 3 == 0 && count > 0 && i > 0)
				{
					cypher = separatorSymbol + cypher;
				}
				
				pre = cypher + pre;
				count ++;
			}
			
			// Format decimals
			
			var numMissingDecimals:int = numDecimals - post.length;
			for (i = 0; i < numMissingDecimals; i++)
			{
				post += "0";
			}
			
			// Join the strings
			
			string = pre;
			if (numDecimals > 0)
			{
				string += decimalSymbol + post;
			}
			
			return string;
		}
				
		public static function colorToHexString(color:Number, prefix:String = "#"):String
		{
			var colArr:Array = color.toString(16).toUpperCase().split('');
			var numChars:int = colArr.length;
		
			for(var a:int=0; a<(6-numChars); a++)
			{
				colArr.unshift("0");
			}
			
			return(prefix + colArr.join(''));
		}	
	}
}