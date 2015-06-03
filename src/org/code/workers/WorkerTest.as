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
		private function log(...args):void
		{
			trace('		worker:',ID,args.join(','));
		}
		
		public function WorkerTest()
		{
			super();

			log('created','	timer:', getTimer());
			timer.addEventListener(TimerEvent.TIMER, handleTimerEvent, false, 0, true);
			log('	SharedProperty:', Worker.current.getSharedProperty(SharedProperties.PRIMS));
			
			Worker.current.setSharedProperty(SharedProperties.MRX_CH, txCh);
			txCh.send('worker-' + ID + ' is ready');
			
			try{
				rxCh.addEventListener(Event.CHANNEL_MESSAGE, handleChannelMSG, false, 0, true);
			}
			catch(e:Error)
			{
				log(e.message + '\n' + e.getStackTrace());
			}
		}
		
		private function get mainWorker():Worker	{return WorkerDomain.current.listWorkers()[0];} 
		
		private var counter:uint;
		private const timer:Timer = new Timer(1000);
		private const ID:uint = Worker.current.getSharedProperty(SharedProperties.WORKER_ID);
		private const txCh:MessageChannel = Worker.current.createMessageChannel(mainWorker);
		private const rxCh:MessageChannel = Worker.current.getSharedProperty(SharedProperties.RX_CH);
		
		public function start():void
		{
			timer.start()
			log('	start');
		}
		
		public function stop():void
		{
			timer.start()
			log('	stop');
		}
		
		private function handleTimerEvent(e:Event):void
		{
			txCh.send('worker ' + ID +'	'+ counter);
			log('	handleTimerEvent:', counter++);
		}
		
		private function handleChannelMSG(e:Event):void
		{
			const msg:Object = rxCh.receive();
			log('	handleChannelMSG', msg);
			try{
				if (msg is String)
					this[msg].call(this);
			}
			catch(e:Error)
			{
				log(e.message,'\n',e.getStackTrace());
			}
		}
	}
}