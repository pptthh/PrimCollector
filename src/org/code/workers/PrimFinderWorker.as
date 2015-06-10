package org.code.workers
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	import flash.utils.ByteArray;
	
	public class PrimFinderWorker extends Sprite
	{
		public static const NAME:String = 'PrimFinderWorker';
		
		private const mainW2BgWCh:MessageChannel = Worker.current.getSharedProperty(SharedProperties.MAIN_2_BG_CH);
		private const bgW2MainWCh:MessageChannel = Worker.current.getSharedProperty(SharedProperties.BG_2_MAIN_CH);
		private const memory:ByteArray = Worker.current.getSharedProperty(SharedProperties.SHARED_MEMORY);
		
		public function PrimFinderWorker()
		{
			trace('	PrimFinderWorker	construct');
			super();
			
//			mainW2BgWCh.addEventListener(Event.CHANNEL_MESSAGE, handleMSG, false, 0, true);
//			mainW2BgWCh.addEventListener(Event.CHANNEL_STATE, handleStateCh, false, 0, true);
//			bgW2MainWCh.addEventListener(Event.CHANNEL_STATE, handleStateCh, false, 0, true);
			if (mainW2BgWCh.messageAvailable)
				handleMSG();
		}
		
		private function handleStateCh(event:Event):void
		{
			trace('		handleStateCh', MessageChannel(event.target).state);
		}
		
		private function handleMSG():void
		{
			var data:Object = mainW2BgWCh.receive();
			
//			if (data is uint)
//				return bgW2MainWCh.send(
//					isPrim(data as uint) ?
//						data :
//						undefined
//				);
//			
			if (data == Messages.R_U_READY)
				bgW2MainWCh.send(true);
			while (data = mainW2BgWCh.receive(true))
				bgW2MainWCh.send(
//					isPrim(data as uint) ?
					divideOnly(data as uint) ?
					data :
					undefined
				);
		}
		
		private function divideOnly(x:Number):Boolean
		{
			var i:uint = 5000;
			while (i -- > 0)
				x = x/1.0001;
			return true
		}
		
		private function isPrim(x:uint):Boolean
		{
			const sqX:uint = Math.floor(Math.sqrt(x));
			const prims:ByteArray = this.memory;
			prims.position = 4;
			var prim:uint;
			while (
				(prim = prims.readUnsignedInt()) <= sqX &&
				x % prim != 0
			)
				;
//				trace('		position,length, prim:\t',prims.position, prims.length, prim, '	?',x);
			
			return prim > sqX;
		}
	}
}