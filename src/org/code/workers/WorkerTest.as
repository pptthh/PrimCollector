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
			trace('worker created', ID, '	timer:', getTimer());
			super();
			timer.addEventListener(TimerEvent.TIMER, handleTimerEvent, false, 0, true);
			trace('worker SharedProperty:', Worker.current.getSharedProperty('prims'));
			
			// In the sending worker swf
			rxChannel.addEventListener(Event.CHANNEL_MESSAGE, handleChannelMSG, false, 0, false);
			txChannel.send('worker-' + ID + ' is ready');
		}
		
		private const mainWorker:Worker = Worker(
			(
				function():Worker
				{
					const list:Vector.<Worker> = WorkerDomain.current.listWorkers();
					const length:uint = list.length;
					var i:uint = 0;
					while (i < length)
					{
						if (list[i].isPrimordial)
							return list[i];
						++ i;
					}
					trace ('	WARNING	mainWorker not found');
					return null;
				}
			).call()
		);
		
		private var counter:uint;
		private const timer:Timer = new Timer(1000);
		private const ID:uint = Worker.current.getSharedProperty('workerId');
		private const txChannel:MessageChannel = Worker.current.createMessageChannel(mainWorker);
		private const rxChannel:MessageChannel = Worker.current.getSharedProperty('rxChannel' + ID);
		
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
			trace('		handleChannelMSG', ID);
		}
	}
}