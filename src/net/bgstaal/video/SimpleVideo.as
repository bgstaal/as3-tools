package net.bgstaal.video
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;

	[Event(name="simpleVideoMetaData", type="net.bgstaal.video.SimpleVideoEvent")]
	[Event(name="simpleVideoLoadProgress", type="net.bgstaal.video.SimpleVideoEvent")]
	[Event(name="simpleVideoLoadComplete", type="net.bgstaal.video.SimpleVideoEvent")]
	[Event(name="simpleVideoPlay", type="net.bgstaal.video.SimpleVideoEvent")]
	[Event(name="simpleVideoPause", type="net.bgstaal.video.SimpleVideoEvent")]
	[Event(name="simpleVideoPlayStart", type="net.bgstaal.video.SimpleVideoEvent")]
	[Event(name="simpleVideoPlayStop", type="net.bgstaal.video.SimpleVideoEvent")]
	[Event(name="simpleVideoPlayComplete", type="net.bgstaal.video.SimpleVideoEvent")]
	[Event(name="simpleVideoSeek", type="net.bgstaal.video.SimpleVideoEvent")]
	[Event(name="simpleVideoSeekInvalidTime", type="net.bgstaal.video.SimpleVideoEvent")]
	[Event(name="simpleVideoCuePoint", type="net.bgstaal.video.SimpleVideoEvent")]
	[Event(name="simpleVideoBufferFull", type="net.bgstaal.video.SimpleVideoEvent")]
	[Event(name="simpleVideoBufferFlush", type="net.bgstaal.video.SimpleVideoEvent")]
	[Event(name="simpleVideoBufferEmpty", type="net.bgstaal.video.SimpleVideoEvent")]
	
	public class SimpleVideo extends Sprite
	{
		private var _url:String;
		private var _smoothing:Boolean;
		private var _connection:NetConnection;
		private var _stream:NetStream;
		private var _video:Video;
		private var _soundTransform:SoundTransform;
		private var _isMetaLoaded:Boolean = false;
		private var _doPlay:Boolean = false;
		private var _isPlaying:Boolean = false;
		private var _isLoaded:Boolean = false;
		private var _isFirstPlay:Boolean = true;
		private var _bytesLoaded:Number = 0;
		private var _bytesTotal:Number = 0;
		private var _duration:Number;
		private var _volume:Number = 1;
		private var _pan:Number = 0;
		private var _bufferTime:Number;
		
		public function set volume (value:Number):void
		{
			_volume = value;
			
			if (_stream)
			{
				updateSound();
			}
		}
		
		public function get volume ():Number
		{
			return _volume;
		}
		
		public function set pan (value:Number):void
		{
			_pan = value;
			
			if (_stream)
			{
				updateSound();
			}
		}
		
		public function get pan ():Number
		{
			return _pan;
		}
		
		public function get isPlaying ():Boolean
		{
			return _isPlaying;
		}
		
		public function get bytesLoaded ():Number
		{
			return _bytesLoaded;
		}
		
		public function get bytesTotal ():Number
		{
			return _bytesTotal;	
		}
		
		
		public function get duration ():Number
		{
			return _duration;
		}
		
		public function get time ():Number
		{
			if (_stream)
			{
				return _stream.time;
			}
			else
			{
				return 0;
			}
		}
		
		public function SimpleVideo(url:String, smoothing:Boolean = true, bufferTime:Number = 0.1)
		{
			_url = url;
			_smoothing = smoothing;
			_bufferTime = bufferTime;
			
			super();
			init();
		}
		
		private function init ():void
		{
			setupSound();
			setupVideo();
		}
		
		private function setupSound ():void
		{
			_soundTransform = new SoundTransform();
		}
		
		public function updateSound ():void
		{
			_soundTransform.pan = _pan;
			_soundTransform.volume = _volume;
			_stream.soundTransform = _soundTransform;
		}
		
		private function setupVideo ():void
		{
			_connection = new NetConnection();
			_connection.connect(null);
			
			_stream = new NetStream(_connection);
			_stream.bufferTime = _bufferTime;
			_stream.addEventListener(NetStatusEvent.NET_STATUS, stream_onNetStatus);
			
			var obj:Object = new Object;
			obj.onMetaData = stream_onMetaData;
			obj.onCuePoint = stream_onCuePoint;
			_stream.client = obj;

			_stream.soundTransform = _soundTransform;

			_video = new Video();
			_video.attachNetStream(_stream);
			_video.visible = false;
			_video.smoothing = _smoothing;
			
			addEventListener(Event.ENTER_FRAME, stream_onLoadProgress);
			
			this.addChild(_video);
			
			updateSound();
			_stream.play(_url);
		}
		
		private function stream_onNetStatus (e:NetStatusEvent):void
		{
			switch (e.info.code)
			{
				case "NetStream.Play.Start":
					if (_isFirstPlay) 
					{
						if (!_doPlay) 
						{
							_stream.seek(0);
							_stream.pause();
							_isPlaying = false;
						} 
						else 
						{
							_isPlaying = true;
							this.dispatchEvent(new SimpleVideoEvent(SimpleVideoEvent.SIMPLE_VIDEO_PLAY_START));
						}
						_isFirstPlay = false;
					} 
					else 
					{
						_isPlaying = true;
						this.dispatchEvent(new SimpleVideoEvent(SimpleVideoEvent.SIMPLE_VIDEO_PLAY_START));
					}
					
					break;
				case "NetStream.Play.Stop":
					this.dispatchEvent(new SimpleVideoEvent(SimpleVideoEvent.SIMPLE_VIDEO_PLAY_STOP));
					if (_stream.time>=(_duration*0.9)) {
						this.dispatchEvent(new SimpleVideoEvent(SimpleVideoEvent.SIMPLE_VIDEO_PLAY_COMPLETE));
					}
					break;
				case "NetStream.Seek.Notify":
					this.dispatchEvent(new SimpleVideoEvent(SimpleVideoEvent.SIMPLE_VIDEO_SEEK));
					break;
				case "NetStream.Seek.InvalidTime":
					this.dispatchEvent(new SimpleVideoEvent(SimpleVideoEvent.SIMPLE_VIDEO_SEEK_INVALID_TIME));
					break;
				case "NetStream.Buffer.Full":
					this.dispatchEvent(new SimpleVideoEvent(SimpleVideoEvent.SIMPLE_VIDEO_BUFFER_FULL));
					break;
				case "NetStream.Buffer.Flush":
					this.dispatchEvent(new SimpleVideoEvent(SimpleVideoEvent.SIMPLE_VIDEO_BUFFER_FLUSH));
					break;
				case "NetStream.Buffer.Full":
					this.dispatchEvent(new SimpleVideoEvent(SimpleVideoEvent.SIMPLE_VIDEO_BUFFER_EMPTY));
					break;
			}
		}
		
		private function stream_onMetaData (meta:Object):void
		{
			if (!_isMetaLoaded)
			{
				_isMetaLoaded = true;
				_duration = meta.duration;
				_video.width = meta.width;
				_video.height = meta.height;
				_video.visible = true;
				
				this.dispatchEvent(new SimpleVideoEvent(SimpleVideoEvent.SIMPLE_VIDEO_META_DATA));
			}
		}
		
		private function stream_onCuePoint (info:Object):void
		{
			this.dispatchEvent(new SimpleVideoEvent(SimpleVideoEvent.SIMPLE_VIDEO_CUE_POINT, info));
		}
		
		private function stream_onLoadProgress (e:Event):void
		{
			_bytesLoaded = _stream.bytesLoaded;
			_bytesTotal = _stream.bytesTotal;
			this.dispatchEvent(new SimpleVideoEvent(SimpleVideoEvent.SIMPLE_VIDEO_LOAD_PROGRESS));
			
			if (_stream.bytesLoaded>=_stream.bytesTotal) {
				removeEventListener(Event.ENTER_FRAME, stream_onLoadProgress);
				dispatchEvent(new SimpleVideoEvent(SimpleVideoEvent.SIMPLE_VIDEO_LOAD_COMPLETE));
			}
		}
		
		public function play ():void
		{
			if (_isFirstPlay)
			{
				_doPlay = true;
			}
			else
			{
				_stream.resume();
				_isPlaying = true;
			}
			
			this.dispatchEvent(new SimpleVideoEvent(SimpleVideoEvent.SIMPLE_VIDEO_PLAY));
		}
		
		public function stop():void 
		{
			if (_isPlaying) 
			{
				_stream.seek(0);
				_stream.pause();
				_isPlaying = false;
			}
		}
		public function pause():void 
		{
			if (_isPlaying) 
			{
				_stream.pause();
				_isPlaying = false;
			}
			
			this.dispatchEvent(new SimpleVideoEvent(SimpleVideoEvent.SIMPLE_VIDEO_PAUSE));
		}
		
		public function seek (offset:Number):void
		{
			if (_stream)
			{
				_stream.seek(offset);
			}
		}
		
		
		public function close ():void
		{
			if (_stream)
			{
				try
				{
					_stream.close();
				}
				catch (e:Error)
				{
					
				}
			}
		}
		
	}
}