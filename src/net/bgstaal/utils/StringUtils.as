package net.bgstaal.utils
{
	public class StringUtils
	{
		public function StringUtils ()
		{
			
		}
		
		public static function capitalize (s:String):String
		{
			var s:String = s.substr(0, 1).toUpperCase() + s.substr(1).toLowerCase();
			
			return s;
		}
		
	}
}