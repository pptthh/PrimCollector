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
			trace('worker created', Id, '	timer:', getTimer());
			super();
			timer.addEventListener(TimerEvent.TIMER, handleTimerEvent, false, 0, true);
			trace('worker SharedProperty:', Worker.current.getSharedProperty('prims'));
			
			// In the sending worker swf
			
			var sendChannel:MessageChannel; 
			sendChannel = ;
			
			rxChannel
			Worker.current.createMessageChannel(txChannel);
		}
		
		private const txChannel:MessageChannel = Worker.current.createMessageChannel(WorkerDomain.current);
		private const rxChannel:MessageChannel = Worker.current.getSharedProperty('rxChannel');
		
		private const Id:uint = Worker.current.getSharedProperty('workerId');
		private const timer:Timer = new Timer(1000);
		private var counter:uint;
		
		public function start():void
		{
			timer.start()
			trace('WorkerTest', Id, 'start');
		}
		
		public function stop():void
		{
			timer.start()
			trace('WorkerTest', Id, 'stop');
		}
		
		private function handleTimerEvent(e:Event):void
		{
			trace('WorkerTest', Id, counter++);
		}
	}
}