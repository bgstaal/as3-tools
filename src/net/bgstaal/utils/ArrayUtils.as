package net.bgstaal.utils
{
	public class ArrayUtils
	{
		public function ArrayUtils()
		{
		}
		
		public static function moveElement (array:Array, sourceIndex:Number, targetIndex:Number):Array
		{	
			var myArray:Array = array.concat();
			
			if (targetIndex < sourceIndex) {
				myArray.splice((targetIndex), 0, myArray[sourceIndex]);
				sourceIndex++
				myArray.splice(sourceIndex, 1);
			} else {
				targetIndex++
				myArray.splice((targetIndex), 0, myArray[sourceIndex]);
				myArray.splice(sourceIndex, 1);
			};
			
			return myArray;
		}
		
		public static function removeDuplicates (array:Array):Array
		{
			var tempArray:Array = [];
			
			for (var i:int = 0; i<array.length; i++)
			{
				var obj1:* = array[i];
				
				var excist:Boolean = false;
				for (var j:int = 0; j<tempArray.length; j++)
				{
					var obj2:* = tempArray[j];
					if (obj2 === obj1)
					{
						excist = true;
					}
				}
				
				if (!excist)
				{
					tempArray.push(obj1);
				}
			}
			
			return tempArray;
		}
		
		public static function shuffle (array:Array):Array
		{
			var tempArray:Array = [];
			var length:Number = array.length;
			
			for (var i:int = 0; i<length; i++)
			{
				var index:Number = Math.floor(Math.random()*(array.length-0.1));
				var element:Object = array.splice(index, 1)[0];
				tempArray.push(element);
			}
			
			return tempArray;
		}

	}
}