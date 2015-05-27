package org.code.vo
{
	public final class Prim extends Object
	{
		private var _id:uint
		public function get id():uint		{return _id;}
		
		private var _value:uint
		public function get value():uint	{return _value;}
		
		private var _dist:uint
		public function get distance():uint	{return _dist;}
		
		public function Prim(id:uint, value:uint, distance:uint)
		{
			_id = id;
			_value = value;
			_dist = distance;
		}
	}
}