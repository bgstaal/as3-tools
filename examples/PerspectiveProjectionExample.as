package
{
	import __AS3__.vec.Vector;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	import net.bgstaal.perspectiveprojection.Matrix3d;
	import net.bgstaal.perspectiveprojection.Point2d;
	import net.bgstaal.perspectiveprojection.Point3d;

	[SWF(width="600", height="330", backgroundColor="0xFFFDE2")]
	public class PerspectiveProjectionExample extends Sprite
	{
		private const COLOR:Number = 0x000000;

		private var _cubeWidth:Number;
		private var _cubeHeight:Number;
		private var _cubeDepth:Number;
		private var _cubeX:Number;
		private var _cubeY:Number;
		private var _projectionCenter:Point;
		private var _fieldOfView:Number;
		private var _focalLength:Number;
		private var _pivotPoint:Point3d;
		private var _3dPoints:Vector.<Point3d>;
		private var _2dPoints:Vector.<Point2d>;

		private var _rotationX:Number = 0;
		private var _rotationY:Number = 0;
		private var _rotationZ:Number = 0;

		public function PerspectiveProjectionExample ()
		{
			init();
		}

		private function init ():void
		{
			setProperties();
			createProjection();

			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}

		/**
		 * Set the inital properties for our perspective projection scene
		 */
		private function setProperties ():void
		{
			// set the size properties of the cube
			_cubeWidth = 200;
			_cubeHeight = 200;
			_cubeDepth = 200;

			// Set the position of the cube to the center of the stage
			_cubeX = (stage.stageWidth - _cubeWidth) / 2;
			_cubeY = (stage.stageHeight - _cubeHeight) / 2;

			// Set the projection center (vanishing point) to the center of the stage
			_projectionCenter = new Point(stage.stageWidth / 2, stage.stageHeight / 2);

			// Set the pivot point to be at the 3d center of the cube
			_pivotPoint = new Point3d(_cubeX + (_cubeWidth / 2), _cubeY + (_cubeHeight / 2), _cubeDepth / 2);

			// Set the the field of view to a numver between 1 & 179.
			_fieldOfView = 55;

			// Calculate the focal length based on the width of the stage and the field of view.
			var a:Number = _fieldOfView / 2;
			var b:Number = 90 - a;
			var bRad:Number = b / 180 * Math.PI;
			var opposite:Number = stage.stageWidth / 2;

			_focalLength = opposite * Math.tan(bRad);
		}

		private function enterFrameHandler (e:Event):void
		{
			createProjection();
			_rotationX += 4;
			_rotationY += 4;
		}


		private function createProjection ():void
		{
			create3dPoints();
			rotate3dPoints();
			projectPoints();
			drawPoints();
			drawLines();
		}

		/**
		 * Creates the 3d points based on the properties we set earlier
		 */
		private function create3dPoints ():void
		{
			_3dPoints = new Vector.<Point3d>();

			// add points to create a rectangle of the supplied width and height
			// at the supplied x and y coordinates and a z value of 0
			_3dPoints.push(new Point3d(_cubeX, _cubeY, 0));
			_3dPoints.push(new Point3d(_cubeX + _cubeWidth, _cubeY, 0));
			_3dPoints.push(new Point3d(_cubeX + _cubeWidth, _cubeY + _cubeHeight, 0));
			_3dPoints.push(new Point3d(_cubeX, _cubeY + _cubeHeight, 0));

			// then add the same points again with a z value of the supplied depth
			_3dPoints.push(new Point3d(_cubeX, _cubeY, _cubeDepth));
			_3dPoints.push(new Point3d(_cubeX + _cubeWidth, _cubeY, _cubeDepth));
			_3dPoints.push(new Point3d(_cubeX + _cubeWidth, _cubeY + _cubeHeight, _cubeDepth));
			_3dPoints.push(new Point3d(_cubeX, _cubeY + _cubeHeight, _cubeDepth));
		}

		/**
		 * Loops through the 3d points and rotates each point around the pivot point
		 */
		private function rotate3dPoints ():void
		{
			var rotationMatrix:Matrix3d = Matrix3d.createRotationMatrix(_rotationX, _rotationY, _rotationZ);

			for (var i:int = 0; i < _3dPoints.length; i++)
			{
				var point3d:Point3d = _3dPoints[i];
				point3d.applyMatrix(rotationMatrix, _pivotPoint);
			}
		}

		/**
		 * Loops through and projects the 3d points to create a vector of 2d points.
		 */
		private function projectPoints ():void
		{
			_2dPoints = new Vector.<Point2d>();

			for (var i:int = 0; i < _3dPoints.length; i++)
			{
				var point3d:Point3d = _3dPoints[i];

				// calls the project function on each point3d wich reaturns a point2d
				var point2d:Point2d = point3d.project(_focalLength, _projectionCenter);
				_2dPoints.push(point2d)
			}
		}


		/**
		 * Draws a circle on stage as a visual representation of each point
		 */
		private function drawPoints ():void
		{
			var radius:Number = 5;

			graphics.clear();

			for (var i:int = 0; i < _2dPoints.length; i++)
			{
				var point2d:Point2d = _2dPoints[i];
				graphics.beginFill(COLOR);
				graphics.drawCircle(point2d.x, point2d.y, radius * point2d.t);
				graphics.endFill()
			}
		}


		/**
		 * Draws the lines that connects the eight corners of the cube
		 */
		private function drawLines ():void
		{
			graphics.lineStyle(1, COLOR);

			// draw the first rectangle
			graphics.moveTo(_2dPoints[0].x, _2dPoints[0].y);
			graphics.lineTo(_2dPoints[1].x, _2dPoints[1].y);
			graphics.lineTo(_2dPoints[2].x, _2dPoints[2].y);
			graphics.lineTo(_2dPoints[3].x, _2dPoints[3].y);
			graphics.lineTo(_2dPoints[0].x, _2dPoints[0].y);

			// draw the second rectangle
			graphics.moveTo(_2dPoints[4].x, _2dPoints[4].y);
			graphics.lineTo(_2dPoints[5].x, _2dPoints[5].y);
			graphics.lineTo(_2dPoints[6].x, _2dPoints[6].y);
			graphics.lineTo(_2dPoints[7].x, _2dPoints[7].y);
			graphics.lineTo(_2dPoints[4].x, _2dPoints[4].y);

			// draw lines between the corners of the rectangles
			graphics.moveTo(_2dPoints[0].x, _2dPoints[0].y);
			graphics.lineTo(_2dPoints[4].x, _2dPoints[4].y);

			graphics.moveTo(_2dPoints[1].x, _2dPoints[1].y);
			graphics.lineTo(_2dPoints[5].x, _2dPoints[5].y);

			graphics.moveTo(_2dPoints[2].x, _2dPoints[2].y);
			graphics.lineTo(_2dPoints[6].x, _2dPoints[6].y);

			graphics.moveTo(_2dPoints[3].x, _2dPoints[3].y);
			graphics.lineTo(_2dPoints[7].x, _2dPoints[7].y);
		}

	}
}