package org.code.vo
{
	import flash.events.EventDispatcher;
	import flash.utils.getTimer;

	public class Prim extends EventDispatcher
	{
		public static var prevMaxDistance:uint;
		public static var prevMaxDistanceCount:uint;
		
		private static var timeCollection:Vector.<uint> = new Vector.<uint>();
		private static var timeCollectionDelta:Vector.<uint> = new Vector.<uint>();
		
		private var _id:uint
		public function get id():uint		{return _id;}
		
		private var _value:uint
		public function get value():uint	{return _value;}
		
		private var _dist:uint
		public function get distance():uint	{return _dist;}
		
		private var _maxDist:uint
		public function get maxDistance():uint	{return _maxDist;}
		
		public function Prim(id:uint, value:uint, distance:uint)
		{
			_id = id;
			_value = value;
			_dist = distance;
			prevMaxDistanceCount ++
			if (prevMaxDistance < distance)
				updateMax();
			_maxDist = prevMaxDistance;
		}
		
		private function updateMax():void
		{
			const time:uint = getTimer();
			const length:uint = timeCollection.length;
			const delta:uint = length == 0 ? 0 : time - timeCollection[length - 1];
			timeCollection.push(time);
			timeCollectionDelta.push(delta);
			
			prevMaxDistance = distance;
			trace('	maxDistance	updated		',	distance, '\t', delta, '\t', time);
			trace('	delta:',	timeCollectionDelta, '\t\t',prevMaxDistanceCount);
			prevMaxDistanceCount = 0;
		}
	}
}