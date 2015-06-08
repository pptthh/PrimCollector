package org.code.workers
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	import flash.utils.ByteArray;
	
	import org.code.vo.Prim;
	
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
			
			mainW2BgWCh.addEventListener(Event.CHANNEL_MESSAGE, handleMSG, false, 0, true);
			mainW2BgWCh.addEventListener(Event.CHANNEL_STATE, handleStateCh, false, 0, true);
			bgW2MainWCh.addEventListener(Event.CHANNEL_STATE, handleStateCh, false, 0, true);
		}
		
		private function handleStateCh(event:Event):void
		{
			trace('		handleStateCh', MessageChannel(event.target).state);
		}
		
		private function handleMSG(event:Event):void
		{
			const data:Object = MessageChannel(event.target).receive();
			trace('		handleMSG', data);
			
			if (data is uint)
				return bgW2MainWCh.send(
					isPrim(data as uint) ?
						data
						null
				);
			
			if (data == Messages.R_U_READY)
				return bgW2MainWCh.send(true);
		}
		
		private function isPrim(x:uint):void
		{
			const sqX:uint = Math.floor(Math.sqrt(x));
			const prims:Vector.<uint> = this.prims;
			var i:uint = 1;
			while (
				i < sqX &&
				x % prims[i] != 0
			)
				++ i;
			if (i >= sqX)
			{
				i = primData.length;
				prims.push(x);
				trace(
					'	i:',i,
					'		v:',x,
					'		d',x - Prim(primData[i - 1]).value - 1,
					'		x',Prim.prevMaxDistance,
					'		c',Prim.prevMaxDistanceCount
				); 
				primData.push(
					new Prim(
						i,
						x, 
						x - primData[i - 1].value - 1
					)
				);
			}
		}
	}
}