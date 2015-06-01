package org.code.workers
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class WorkerTest extends Sprite
	{
		public function WorkerTest()
		{
			super();
			trace('worker created', Id);
			timer.addEventListener(TimerEvent.TIMER, handleEvent, false, 0, true);
		}
		
		private static const Id:uint = Math.random() * 100;
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
		
		private function handleEvent(e:Event):void
		{
			trace('WorkerTest', Id, counter++);
		}
	}
}