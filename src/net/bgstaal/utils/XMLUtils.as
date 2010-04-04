package net.bgstaal.utils
{
	public class XMLUtils
	{
		public static function spliceXmlList (xmlList:XMLList, startIndex:int, length:int):XMLList
		{
			var list:XMLList = new XMLList();
			var endIndex:int = startIndex + length;
			
			if (endIndex > xmlList.length())
			{
				endIndex = xmlList.length();
			}
			
			for (var i:int = startIndex; i < endIndex; i++)
			{
				var obj:XML = xmlList[i];
				list += obj;
			}
			
			return list;
		}

	}
}