package net.bgstaal.utils
{
	import com.bleed.utils.DateUtils;
	import flash.utils.getQualifiedClassName;
	//import flash.utils.getQualifiedClassName;
	//import flash.utils.getQualifiedClassName;
	//import flash.utils.getQualifiedClassName;
	
	public class Log
	{
		public function Log()
		{
			
		}
		
		private static const INFO:String = "info";
		private static const ERROR:String = "error";
		private static const WARNING:String = "warning";
		
		public static function info (scope:Object, message:String):void
		{
			log(scope, message, Log.INFO);	
		}
		
		public static function warning (scope:Object, message:String):void
		{
			log(scope, message, Log.WARNING);	
		}
		
		
		public static function error (scope:Object, message:String):void
		{
			log(scope, message, Log.ERROR);	
		}
		
		
		private static function log (scope:Object, message:String, level:String):void
		{
			var classPath:String = getQualifiedClassName(scope).split("::").join(".");
			var dateString:String = DateUtils.dateToString(new Date(), ":", DateUtils.HHMMSS);
			
			
			trace("[[ " + level.toUpperCase() + " | " + dateString + " | " + classPath + " ]] "  + message);
		}

	}
}