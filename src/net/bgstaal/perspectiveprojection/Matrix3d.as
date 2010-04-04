package net.bgstaal.perspectiveprojection
{
	/**
	 * <b>Matrix3d ©2009, bgstaal.net</b>
	 * <hr/>
	 * The Matrix3d class let's you create 3x4 transformation matrices wich can be applied to Point3d instances.
	 * @author		Bjørn Gunnar Staal
	 * @version		1.0
	 */
	public class Matrix3d
	{
		private static const DEGREES_TO_RADIANS:Number = 1/180*Math.PI;
		
		/**
		 * <p>
		 * X  0  0  0  <br/>
		 * 0  0  0  0  <br/>
		 * 0  0  0  0  <br/>
		 * </p>
		 */
		public var n11:Number;
		
		/**
		 * <p>
		 * 0  X  0  0  <br/>
		 * 0  0  0  0  <br/>
		 * 0  0  0  0  <br/>
		 * </p>
		 */
		public var n12:Number;
		
		/**
		 * <p>
		 * 0  0  X  0  <br/>
		 * 0  0  0  0  <br/>
		 * 0  0  0  0  <br/>
		 * </p>
		 */
		public var n13:Number;
		
		/**
		 * <p>
		 * 0  0  0  X  <br/>
		 * 0  0  0  0  <br/>
		 * 0  0  0  0  <br/>
		 * </p>
		 */
		public var n14:Number;
		
		/**
		 * <p>
		 * 0  0  0  0  <br/>
		 * X  0  0  0  <br/>
		 * 0  0  0  0  <br/>
		 * </p>
		 */
		public var n21:Number;
		
		/**
		 * <p>
		 * 0  0  0  0  <br/>
		 * 0  X  0  0  <br/>
		 * 0  0  0  0  <br/>
		 * </p>
		 */
		public var n22:Number;
		
		/**
		 * <p>
		 * 0  0  0  0  <br/>
		 * 0  0  X  0  <br/>
		 * 0  0  0  0  <br/>
		 * </p>
		 */
		public var n23:Number;
		
		/**
		 * <p>
		 * 0  0  0  0  <br/>
		 * 0  0  0  X  <br/>
		 * 0  0  0  0  <br/>
		 * </p>
		 */
		public var n24:Number;
		
		/**
		 * <p>
		 * 0  0  0  0  <br/>
		 * 0  0  0  0  <br/>
		 * X  0  0  0  <br/>
		 * </p>
		 */
		public var n31:Number;
		
		/**
		 * <p>
		 * 0  0  0  0  <br/>
		 * 0  0  0  0  <br/>
		 * 0  X  0  0  <br/>
		 * </p>
		 */
		public var n32:Number;
		
		/**
		 * <p>
		 * 0  0  0  0  <br/>
		 * 0  0  0  0  <br/>
		 * 0  0  X  0  <br/>
		 * </p>
		 */
		public var n33:Number;
		
		/**
		 * <p>
		 * 0  0  0  0  <br/>
		 * 0  0  0  0  <br/>
		 * 0  0  0  X  <br/>
		 * </p>
		 */
		public var n34:Number;
		
		
		/**
		 * Create a new Matrix3d Object.
		 * By default a 4x3 identity matrix is created.
		 * @param	n11		The value in the first collumn of the first row
		 * @param	n12		The value in the second collumn of the first row
		 * @param	n13		The value in the third collumn of the first row
		 * @param	n14		The value in the fourth collumn of the first row
		 * @param	n21		The value in the first collumn of the second row
		 * @param	n22		The value in the second collumn of the second row
		 * @param	n23		The value in the third collumn of the second row
		 * @param	n24		The value in the fourth collumn of the second row
		 * @param	n31		The value in the first collumn of the third row
		 * @param	n32		The value in the second collumn of the third row
		 * @param	n33		The value in the third collumn of the third row
		 * @param	n34		The value in the fourth collumn of the third row
		 */
		public function Matrix3d(n11:Number = 1, n12:Number = 0, n13:Number = 0, n14:Number = 0,
								 n21:Number = 0, n22:Number = 1, n23:Number = 0, n24:Number = 0,
								 n31:Number = 0, n32:Number = 0, n33:Number = 1, n34:Number = 0)
		{
			this.n11 = n11;
			this.n12 = n12;
			this.n13 = n13;
			this.n14 = n14;
			this.n21 = n21;
			this.n22 = n22;
			this.n23 = n23;
			this.n24 = n24;
			this.n31 = n31;
			this.n32 = n32;
			this.n33 = n33;
			this.n34 = n34;
		}
		
		/**
		 * Creates a transformation matrix with the supplied rotation around either axis
		 * @param	xRotation	The number of degrees of rotation that should be applied around the x axis. (roll)
		 * @param	yRotation	The number of degrees of rotation that should be applied around the y axis. (pitch)
		 * @param	zRotation	The number of degrees of rotation that should be applied around the z axis. (yaw)
		 * @return	A Matrix3d instance with the supplied rotations applied.
		 */
		public static function createRotationMatrix (xRotation:Number, yRotation:Number, zRotation:Number):Matrix3d
		{
			var xMatrix:Matrix3d = createXRotationMatrix(xRotation);
			var yMatrix:Matrix3d = createYRotationMatrix(yRotation);
			var zMatrix:Matrix3d = createZRotationMatrix(zRotation);
			
			var m:Matrix3d = multiplySeveral(xMatrix, yMatrix, zMatrix);
			
			return m;
		}
		
		/**
		 * Creates a rotation matrix with the supplied rotation around the x axis. (roll)
		 * @param	rotation	The number of degrees of rotation that should be applied around the x axis
		 * @return	A Matrix3d instance with the supplied x rotation applied.
		 */
		public static function createXRotationMatrix (rotation:Number):Matrix3d
		{
			var radians:Number = rotation*DEGREES_TO_RADIANS;
			
			var n:Array = [1, 0, 0, 0,
						   0, Math.cos(radians), Math.sin(radians), 0,
						   0, -Math.sin(radians), Math.cos(radians), 0];
			
			return matrix3dFromArray(n);
		}

		/**
		 * Creates a rotation matrix with the supplied rotation around the y axis. (pitch)
		 * @param	rotation	The number of degrees of rotation that should be applied around the y axis
		 * @return	A Matrix3d instance with the supplied y rotation applied.
		 */
		public static function createYRotationMatrix (rotation:Number):Matrix3d
		{
			var radians:Number = rotation*DEGREES_TO_RADIANS;
			
			var n:Array = [Math.cos(radians), 0, Math.sin(radians), 0,
						   0, 1, 0, 0,
						   -Math.sin(radians), 0, Math.cos(radians), 0];
			
			return matrix3dFromArray(n);
		}
		
		/**
		 * Creates a rotation matrix with the supplied rotation around the z axis. (yaw)
		 * @param	rotation	The number of degrees of rotation that should be applied around the z axis
		 * @return	A Matrix3d instance with the supplied z rotation applied.
		 */
		public static function createZRotationMatrix (rotation:Number):Matrix3d
		{
			var radians:Number = rotation*DEGREES_TO_RADIANS;
			
			var n:Array = [Math.cos(radians), Math.sin(radians), 0, 0,
						   -Math.sin(radians), Math.cos(radians), 0, 0,
						   0, 0, 1, 0];
														 
			return matrix3dFromArray(n);
		}
		
		/**
		 * Creates a translation matrix with the supplied values for translation along the x, y & z axis
		 * @param	xTranslation	The number of pixels to offset along the x axis
		 * @param	yTranslation	The number of pixels to offset along the y axis
		 * @param	zTranslation	The number of pixels to offset along the z axis
		 * @return	A Matrix3d instance with the supplied translation applied.
		 */
		public static function createTranslationMatrix (xTranslation:Number = 0, yTranslation:Number = 0, zTranslation:Number = 0):Matrix3d
		{
			var n:Array = [1, 0, 0, xTranslation,
						   0, 1, 0, yTranslation,
						   0, 0, 1, zTranslation]
			
			return matrix3dFromArray(n);
		}
		
		/**
		 * Creates a scaling matrix with the supplied values for scale along the x, y & z axis
		 * @param	xScale	The number of pixels to offset along the x axis
		 * @param	yScale	The number of pixels to offset along the y axis
		 * @param	zScale	The number of pixels to offset along the z axis
		 * @return	A Matrix3d instance with the supplied scaling applied.
		 */
		public static function createScalingMatrix (xScale:Number = 0, yScale:Number = 0, zScale:Number = 0):Matrix3d
		{
			var n:Array = [xScale, 0, 0, 0,
						   0, yScale, 0, 0,
						   0, 0, zScale, 0];
			
			return matrix3dFromArray(n);
		}
		
		/**
		 * Creates a Matrix3d filled with the values from the supplied array
		 * @param	n	A Array instance with 12 entries representing the numbers in the matrix starting with the top left collumn and ending with the bottom right.
		 * @return	A Matrix3d instance filled with the supplied values
		 */
		public static function matrix3dFromArray (n:Array):Matrix3d
		{
			if (n.length == 12)
			{
				var m:Matrix3d = new Matrix3d(n[0], n[1], n[2], n[3], n[4], n[5], n[6], n[7], n[8], n[9], n[10], n[11]);
				return m;
			}
			else
			{
				return null;
			}
		}
		
		/**
		 * Multiplies two Matrix3d instances and returns the result
		 * @param	a	The first matrix
		 * @param	b	The seconds matrix
		 * @return	A Matrix3d instance representing the result of the multiplication
		 */
		public static function multiply (a:Matrix3d, b:Matrix3d):Matrix3d
		{
			var c:Matrix3d = new Matrix3d();
			
			c.n11 = a.n11 * b.n11 + a.n12 * b.n21 + a.n13 * b.n31;
			c.n12 = a.n11 * b.n12 + a.n12 * b.n22 + a.n13 * b.n32;
			c.n13 = a.n11 * b.n13 + a.n12 * b.n23 + a.n13 * b.n33;
			c.n14 = a.n11 * b.n14 + a.n12 * b.n24 + a.n13 * b.n34 + a.n14;
		
			c.n21 = a.n21 * b.n11 + a.n22 * b.n21 + a.n23 * b.n31;
			c.n22 = a.n21 * b.n12 + a.n22 * b.n22 + a.n23 * b.n32;
			c.n23 = a.n21 * b.n13 + a.n22 * b.n23 + a.n23 * b.n33;
			c.n24 = a.n21 * b.n14 + a.n22 * b.n24 + a.n23 * b.n34 + a.n24;
		
			c.n31 = a.n31 * b.n11 + a.n32 * b.n21 + a.n33 * b.n31;
			c.n32 = a.n31 * b.n12 + a.n32 * b.n22 + a.n33 * b.n32;
			c.n33 = a.n31 * b.n13 + a.n32 * b.n23 + a.n33 * b.n33;
			c.n34 = a.n31 * b.n14 + a.n32 * b.n24 + a.n33 * b.n34 + a.n34;
			
			return c;
		}
		
		/**
		 * Multiplies several Matrix3d instances and returns the result
		 * @param	matrices	The Matrix3d instances that should be multiplied.
		 * @return	A Matrix3d instance representing the result of the multiplication
		 */
		public static function multiplySeveral (...matrices):Matrix3d
		{
			var newMatrix:Matrix3d = matrices[0];
			var i:int = 0;
			var length:Number = matrices.length;
			
			for (i = 1; i < length; ++i)
			{
				var m:Matrix3d = matrices[i];
				newMatrix = multiply(newMatrix, m);
			}
			
			return newMatrix;
		}
		
		/**
		 * Applies the transformation to a Point3d around a pivot point and returns a new point3d
		 * @param	p			The point witch the transformation should be applied to.
		 * @param	pivotPoint	The point in 3d witch the transformation should be applied around. The coordinates (0,0,0) is used if no value is supplied.
		 * @return	A new Point3d representing the supplied Point3d instance with the transformations applied.
		 */
		public function apply (p:Point3d, pivotPoint:Point3d = null):Point3d
		{
			if (!pivotPoint)
			{
				pivotPoint = new Point3d();
			}
			
			var _x:Number = p.x - pivotPoint.x;
			var _y:Number = p.y - pivotPoint.y;
			var _z:Number = p.z - pivotPoint.z;
			
			var x:Number = (_x * n11) + (_y * n12) + (_z * n13) + n14 + pivotPoint.x;
			var y:Number = (_x * n21) + (_y * n22) + (_z * n23) + n24 + pivotPoint.y;
			var z:Number = (_x * n31) + (_y * n32) + (_z * n33) + n34 + pivotPoint.z;
			
			return new Point3d(x, y, z);
		}
	}
}