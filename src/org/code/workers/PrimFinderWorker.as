package org.code.workers
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	import flash.utils.flash_proxy;
	
	public class PrimFinderWorker extends Sprite
	{
		public static const NAME:String = 'PrimFinderWorker';
		
		private const mainW2BgWCh:MessageChannel = Worker.current.getSharedProperty(SharedProperties.MAIN_2_BG_CH);
		private const bgW2MainWCh:MessageChannel = Worker.current.getSharedProperty(SharedProperties.BG_2_MAIN_CH);
		
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
			trace('		handleStateCh');
		}
		
		private function handleMSG(event:Event):void
		{
			const data:String = MessageChannel(event.target).receive() as String;
			trace('		handleMSG', data);
			if (data.lastIndexOf('ready?') >= 0)
				return bgW2MainWCh.send('ready!');
		}
	}
}