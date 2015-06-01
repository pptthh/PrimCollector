package org.code.workers
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public final class BgWorkerPrimFinder extends EventDispatcher
	{
		public function BgWorkerPrimFinder(target:IEventDispatcher=null)
		{
			trace('		BgWorkerPrimFinder');
			super(target);
		}
	}
}