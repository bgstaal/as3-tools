package net.bgstaal.data
{
	public class Country
	{
		public var name:String;
		public var code:String;
		
		public function Country(name:String, code:String)
		{
			this.name = name;
			this.code = code;
		}
		
		public function toString ():String
		{
			var s:String = name + ";" + code
			return s;
		}

	}
}