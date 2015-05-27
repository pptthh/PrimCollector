package org.code.vo.list
{
	import flash.events.EventDispatcher;
	
	import mx.collections.IList;
	
	public final class VectorUintList extends EventDispatcher implements IList
	{
		private var cls:Class;
		private var list:Vector.<*>;
		
		public function VectorUintList(list:Vector.<uint>, cls:Class)
		{
			this.cls = cls;
			this.list = list;
		}
		
		public function get length():int	{return list.length}
		
		public function addItem(item:Object):void
		{
			if (item is cls)
				list.push(item)
		}
		
		public function addItemAt(item:Object, index:int):void
		{
			if (item is cls)
				list.splice(index, 0, item);
		}
		
		public function getItemAt(index:int, prefetch:int=0):Object	{return list[index];}
		
		public function getItemIndex(item:Object):int				{return list.indexOf(item);}
		
		public function itemUpdated(item:Object, property:Object=null, oldValue:Object=null, newValue:Object=null):void
		{
			trace('		What???\n\t\titem, property, oldValue, newValue:',item, property, oldValue, newValue);
		}
		
		public function removeAll():void							{list.length = 0;}
		
		public function removeItemAt(index:int):Object
		{
			const olditem:* = list[index];
			list.splice(index,1);
			return olditem;
		}
		
		public function setItemAt(item:Object, index:int):Object
		{
			const olditem:* = list[index];
			list[index] = cls(item);
			return olditem;
		}
		
		public function toArray():Array
		{
			const list:Vector.<*> = this.list;
			var length:uint = list.length;
			const arr:Array = new Array(length);
			var i:uint = 0;
			
			while(i < length)
				arr[i] = list[i ++];
			return arr;
		}
	}
}