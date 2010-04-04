package net.bgstaal.drawing
{
	import flash.display.Graphics;
	
	/*
     * This class is based on code written by Lee Brimelow.
     * I basically copied the drawArc function from his Arc.as class and 
     * made the proper adjustments to make the class draw an wedge instead of a arc.
     * the reason why I copied the function instead of just extending it is
     * that I wanted the class to be self-contained and independant.
    */
	
	
	public class Wedge
	{
		
		public static function draw (graphicsObj:Graphics, radius:Number, angle:Number, startAngle:Number = 0, centerX:Number = 0, centerY:Number = 0):void
		{
			if (angle<360)
			{
				var xOffset:Number = Math.cos(startAngle*Math.PI/180)*radius;
				var yOffset:Number = Math.sin(startAngle*Math.PI/180)*radius;
				
				graphicsObj.moveTo(centerX, centerY);
				graphicsObj.lineTo(centerX + xOffset, centerY + yOffset);
				drawArc(graphicsObj, centerX + xOffset, centerY + yOffset, radius, angle, startAngle);
				graphicsObj.lineTo(centerX, centerY);
			}
			else
			{
				graphicsObj.drawCircle(centerX, centerY, radius);
			}
		}
		
		private static function drawArc(graphicsObj:Graphics, sx:Number, sy:Number, radius:Number, arc:Number, startAngle:Number=0):void
        {
                var segAngle:Number;
                var angle:Number;
                var angleMid:Number;
                var numOfSegs:Number;
                var ax:Number;
                var ay:Number;
                var bx:Number;
                var by:Number;
                var cx:Number;
                var cy:Number;
                
                // Move the pen
                graphicsObj.moveTo(sx, sy);
        
                // No need to draw more than 360
                if (Math.abs(arc) > 360) 
                {
                        arc = 360;
                }
        
                numOfSegs = Math.ceil(Math.abs(arc) / 45);
                segAngle = arc / numOfSegs;
                segAngle = (segAngle / 180) * Math.PI;
                angle = (startAngle / 180) * Math.PI;
                
                // Calculate the start point
                ax = sx - Math.cos(angle) * radius;
                ay = sy - Math.sin(angle) * radius;
        
                for(var i:int=0; i<numOfSegs; i++) 
                {
                        // Increment the angle
                        angle += segAngle;
                        
                        // The angle halfway between the last and the new
                        angleMid = angle - (segAngle / 2);
                        
                        // Calculate the end point
                        bx = ax + Math.cos(angle) * radius;
                        by = ay + Math.sin(angle) * radius;
                        
                        // Calculate the control point
                        cx = ax + Math.cos(angleMid) * (radius / Math.cos(segAngle / 2));
                        cy = ay + Math.sin(angleMid) * (radius / Math.cos(segAngle / 2));

                        // Draw out the segment
                        graphicsObj.curveTo(cx, cy, bx, by);
                }
        }

	}
}