package net.bgstaal.perspectiveprojection
{
	import flash.geom.Point;
	
	/**
	 * <b>Point3d ©2009, bgstaal.net</b>
	 * <hr/>
	 * The Point3d holds the properties to represent a single point i 3d space (x,y,z) 
	 * and the methods to apply transformation matrices and return a 2d representation
	 * of the 3d point.
	 * @author		Bjørn Gunnar Staal
	 * @version		1.0
	 */
	public class Point3d
	{
		/**
		 * The x coordinate
		 */
		public var x:Number;
		
		/**
		 * The y coordinate
		 */
		public var y:Number;
		
		/**
		 * The z coordinate
		 */
		public var z:Number;
		
		/**
		 * Creates a Point3d instance
		 * @param	x	The x coordinate
		 * @param	y	The y coordinate
		 * @param	z	The z coordinate
		 */
		public function Point3d(x:Number = 0, y:Number = 0, z:Number = 0)
		{
			this.x = x;
			this.y = y;
			this.z = z;
		}
		
		/**
		 * Performs a perspective projection on the instance and returns a 2d represenation of the 3d coordinates
		 * @param		focalLength			Distance from camera to the stage
		 * @param		projectionCenter	2d coordinate representing the center of the viewing frustrum (vanishing point)
		 * @return		A Point2d instance representing a projected version of <code>this<code>
		 */
		public function project (focalLength:Number, projectionCenter:Point = null):Point2d
		{
			var t:Number = focalLength / (focalLength+z);
			
			if (!projectionCenter)
			{
				projectionCenter = new Point(0, 0);
			}
			
			var xOffset:Number = projectionCenter.x;
			var yOffset:Number = projectionCenter.y;
			
			var x:Number = this.x;
			var y:Number = this.y;
			var z:Number = this.z;
			
			x -= xOffset;
			y -= yOffset;
			
			x = (x*t)+xOffset;
			y = (y*t)+yOffset;
			
			return new Point2d(x, y, t);
		}
		
		/**
		 * Applies the supplied transformation matrix to the point around the supplied pivot point
		 * @param		m				Matrix3d instance with the transformation values
		 * @param		pivotPoint		A Point in 3d witch the transformation should be applied around. The coordinates (0,0,0) is used if no value is supplied.
		 */
		public function applyMatrix (m:Matrix3d, pivotPoint:Point3d = null):void
		{
			if (!pivotPoint)
			{
				pivotPoint = new Point3d();
			}
			
			var p:Point3d = m.apply(this, pivotPoint);
			
			this.x = p.x;
			this.y = p.y;
			this.z = p.z;
		}

	}
}