package net.bgstaal.utils
{
	import flash.geom.Point;
	
	public class Trigonometry
	{
		public function Trigonometry ():void
		{
			
		}
		
		public static function getDistance (p1:Point, p2:Point):Number
		{
			var adjacent:Number = p2.x - p1.x;
			var opposite:Number = p2.y - p1.y;
			
			var distance:Number = Math.sqrt(Math.pow(adjacent, 2)+Math.pow(opposite, 2))
			
			return distance;
		}
		
		public static function getAngle (p1:Point, p2:Point):Number
		{
			var adjside:Number = p2.x - p1.x;
			var oppside:Number = -1*(p2.y - p1.y);
			
			var angle:Number = Math.atan2(oppside, adjside);
			angle = Math.round(angle/Math.PI*180);
			
			if (angle < 0)
			{
				angle = 360 + angle;
			}
			
			return angle;
		}
		
		public static function getAngleFlipped (p1:Point, p2:Point):Number
		{			
			return 360 - getAngle(p1, p2);
		}
		
		public static function getPointFromAngleAndDistance (origin:Point, angle:Number, distance:Number):Point
		{
			var xDis:Number = Math.cos(angle*(Math.PI/180))*distance;
			var yDis:Number = Math.sin(angle*(Math.PI/180))*distance;
			
			return new Point(origin.x + xDis, origin.y + yDis)
		}
		
		public static function getRadiansFromDegrees (degrees:Number):Number
		{
			return degrees/180*Math.PI;
		}
		
		
	}
}