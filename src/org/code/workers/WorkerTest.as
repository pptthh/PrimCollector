package org.code.workers
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.system.MessageChannel;
	import flash.system.MessageChannelState;
	import flash.system.Worker;
	import flash.system.WorkerDomain;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	trace('worker pre-init');	
	
	public class WorkerTest extends Sprite
	{
		private function log(...args):void
		{
//			trace('		worker:',ID,args.join(','));
		}
		
		public function WorkerTest()
		{
			super();

			log('created','	timer:', getTimer());
			timer.addEventListener(TimerEvent.TIMER, handleTimerEvent, false, 0, true);
			log('	SharedProperty:', Worker.current.getSharedProperty(SharedProperties.PRIMS));

			rxCh.addEventListener(Event.CHANNEL_MESSAGE, handleChannelMSG, false, 0, true);
			
			txCh.send('worker ' + ID +'	'+ counter);
			if (txCh.state == MessageChannelState.CLOSED)
				trace(MessageChannelState.CLOSED);
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
		private const ID:uint = Worker.current.getSharedProperty(SharedProperties.WORKER_ID);
		private const rxCh:MessageChannel = Worker.current.getSharedProperty(SharedProperties.RX_CH);
		private const txCh:MessageChannel = 
		(
			function ():MessageChannel
			{
				for (var i:uint = 5; i -- > 0;)
				{
					var  txCh:MessageChannel = Worker.current.createMessageChannel(mainWorker);
					
					if (txCh.state == MessageChannelState.CLOSED)
						continue;
					break;
				}
				Worker.current.setSharedProperty(SharedProperties.MRX_CH, txCh);
				return txCh
			}
		).call(this);
		
		private function start():void
		{
			timer.start();
			log('	start');
			//txCh.send('worker-' + ID + ' is ready');
		}
		
		private function stop():void
		{
			timer.stop()
			log('	stop');
		}
		
		private function handleTimerEvent(e:Event):void
		{
			txCh.send('worker ' + ID +'	'+ counter);
			log('	handleTimerEvent:', counter++);
			stop();
		}
		
		private function handleChannelMSG(e:Event):void
		{
			const msg:Object = rxCh.receive();
			try{
				if (msg is String)
					this[msg].call(this);
			}
			catch(e:Error)
			{
				log('	handleChannelMSG', msg);
				log(e.message,'\n',e.getStackTrace());
			}
		}
	}
}