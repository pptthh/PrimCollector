package org.code.workers
{
	import flash.display.Sprite;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	import flash.utils.ByteArray;
	
	public final class PrimFinderWorker extends Sprite
	{
		public static const NAME:String = 'PrimFinderWorker';
		
		private const memory:ByteArray = Worker.current.getSharedProperty(SharedProperties.SHARED_MEMORY);
		
		public final function PrimFinderWorker()
		{
			trace('	PrimFinderWorker	construct');
			super();
			
			const mainW2BgWCh:MessageChannel = Worker.current.getSharedProperty(SharedProperties.MAIN_2_BG_CH);
			const bgW2MainWCh:MessageChannel = Worker.current.getSharedProperty(SharedProperties.BG_2_MAIN_CH);
			
			var data:Object = mainW2BgWCh.receive(true);
			
			if (data == Messages.R_U_READY)
				bgW2MainWCh.send(true);

			while (data = mainW2BgWCh.receive(true))
				bgW2MainWCh.send(
					isPrim(data as uint) ?
						data :
						null
				);
		}
		
		//	need also a FlasCC asc2.jar compiler argument: -inline  
		[Inline]
		
		private function isPrim(x:uint):Boolean
		{
			const sq_X:uint = Math.floor(Math.sqrt(x));
			const prims:ByteArray = this.memory;
			prims.position = 4;
			
			var prim:uint = prims.readUnsignedInt();
			
			while (prim <= sq_X && x % prim != 0)
				prim = prims.readUnsignedInt();
			
			return prim > sq_X;
		}
	}
}