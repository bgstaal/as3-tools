package net.bgstaal.perspectiveprojection
{
	/**
	 * <b>Point2d ©2009, bgstaal.net</b>
	 * <hr/>
	 * A instance if the Point2d class represents a projected Point3d as a 2d coordinate (x, y) and the value t (scale)
	 * @author		Bjørn Gunnar Staal
	 * @version		1.0
	 */
	public class Point2d
	{
		/**
		 * The points x coordinate
		 */
		public var x:Number;
		
		/**
		 * The points y coordinate
		 */
		public var y:Number;
		
		/**
		 * The value t represents the points scale
		 */
		public var t:Number;
		
		/**
		 * Create a Point2d instance
		 * @param	x	The x coordinate
		 * @param	y	The y coordinate
		 * @param	t	The value t represents the points scale
		 */
		public function Point2d(x:Number, y:Number, t:Number)
		{
			this.x = x;
			this.y = y;
			this.t = t;
		}
		
		/**
		 * Returns the x, y & t values as a string
		 * @return	A string representation of the public properties.
		 */
		public function toString ():String
		{
			return "x: " + x + ", y: " + y + ", t: " + t;
		}

	}
}