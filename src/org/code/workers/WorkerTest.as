package org.code.workers
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	import flash.system.WorkerDomain;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	trace('worker pre-init');	
	
	public class WorkerTest extends Sprite
	{
		public function WorkerTest()
		{
			trace('worker created', ID, '	timer:', getTimer(), '	txCh, rxCh	',txCh, rxCh, Worker.current.getSharedProperty(SharedProperties.RX_CH));
			super();
			timer.addEventListener(TimerEvent.TIMER, handleTimerEvent, false, 0, true);
			trace('worker SharedProperty:', Worker.current.getSharedProperty(SharedProperties.PRIMS));
			
			// In the sending worker swf
			
			rxCh.addEventListener(Event.CHANNEL_MESSAGE, handleChannelMSG, false, 0, true);

			Worker.current.setSharedProperty(SharedProperties.RX_CH, txCh);
			txCh.send('worker-' + ID + ' is ready');
		}
		
		private function get mainWorker():Worker	{return WorkerDomain.current.listWorkers()[0];} 
//		private const mainWorker:Worker = Worker(
//			(
//				function():Worker
//				{
//					const list:Vector.<Worker> = WorkerDomain.current.listWorkers();
//					const length:uint = list.length;
//					var i:uint = 0;
//					while (i < length)
//					{
//						if (list[i].isPrimordial)
//							return list[i];
//						++ i;
//					}
//					trace ('	WARNING	mainWorker not found');
//					return null;
//				}
//			).call()
//		);
		
		private var counter:uint;
		private const timer:Timer = new Timer(1000);
		private const ID:uint = Worker.current.getSharedProperty(SharedProperties.WORKER_ID);
		private const txCh:MessageChannel = Worker.current.createMessageChannel(mainWorker);
		private const rxCh:MessageChannel = Worker.current.getSharedProperty(SharedProperties.RX_CH);
		
		public function start():void
		{
			timer.start()
			trace('WorkerTest', ID, 'start');
		}
		
		public function stop():void
		{
			timer.start()
			trace('WorkerTest', ID, 'stop');
		}
		
		private function handleTimerEvent(e:Event):void
		{
			trace('WorkerTest', ID, counter++);
		}
		
		private function handleChannelMSG(e:Event):void
		{
			const msg:Object = rxCh.receive();
			trace('		handleChannelMSG', ID, msg);
			try{
				if (msg is String)
					this[msg].call(this);
			}
			catch(e:Error)
			{
				trace(e.message,'\n',e.getStackTrace());
			}
		}
	}
}