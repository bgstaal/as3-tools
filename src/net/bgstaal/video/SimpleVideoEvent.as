package net.bgstaal.video
{
	import flash.events.Event;

	public class SimpleVideoEvent extends Event
	{
		public static const SIMPLE_VIDEO_META_DATA:String = "simpleVideoMetaData";
		public static const SIMPLE_VIDEO_LOAD_PROGRESS:String = "simpleVideoLoadProgress";
		public static const SIMPLE_VIDEO_LOAD_COMPLETE:String = "simpleVideoLoadComplete";
		public static const SIMPLE_VIDEO_PLAY:String = "simpleVideoPlay";
		public static const SIMPLE_VIDEO_PAUSE:String = "simpleVideoPause";
		public static const SIMPLE_VIDEO_PLAY_START:String = "simpleVideoPlayStart";
		public static const SIMPLE_VIDEO_PLAY_STOP:String = "simpleVideoPlayStop";
		public static const SIMPLE_VIDEO_PLAY_COMPLETE:String = "simpleVideoPlayComplete";
		public static const SIMPLE_VIDEO_SEEK:String = "simpleVideoSeek";
		public static const SIMPLE_VIDEO_SEEK_INVALID_TIME:String = "simpleVideoSeekInvalidTime";
		public static const SIMPLE_VIDEO_CUE_POINT:String = "simpleVideoCuePoint";
		public static const SIMPLE_VIDEO_BUFFER_FULL:String = "simpleVideoBufferFull";
		public static const SIMPLE_VIDEO_BUFFER_EMPTY:String = "simpleVideoBufferEmpty";
		public static const SIMPLE_VIDEO_BUFFER_FLUSH:String = "simpleVideoBufferFlush";
		
		public function SimpleVideoEvent(type:String, cuePoint:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}