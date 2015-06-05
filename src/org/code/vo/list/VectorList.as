package org.code.vo.list
{
	import flash.events.EventDispatcher;
	
	import mx.collections.IList;
	
	public final class VectorList extends EventDispatcher implements IList
	{
		private var cls:Class;
		private var list:Vector.<Object>;
		
		public function VectorList(list:Vector.<Object>, cls:Class)
		{
			this.cls = cls;
			this.list = list;
		}
		
		public function get length():int							{return list.length}
		public function addItem(item:Object):void					{list.push(item as cls)}
		public function addItemAt(item:Object, index:int):void		{list.splice(index, 0, item as cls)}
		public function getItemAt(index:int, prefetch:int=0):Object	{return list[index]}
		public function getItemIndex(item:Object):int				{return list.indexOf(item)}
		public function removeAll():void							{list.length = 0;}
		
		public function itemUpdated(item:Object, property:Object=null, oldValue:Object=null, newValue:Object=null):void
		{
			trace('		What???\n\t\titem, property, oldValue, newValue:',item, property, oldValue, newValue);
		}
		
		public function removeItemAt(index:int):Object
		{
			const olditem:* = list[index];
			has
			list.splice(index,1);
			return olditem;
			
		}
		
		public function setItemAt(item:Object, index:int):Object
		{
			const olditem:Object = list[index];
			list[index] = cls(item);
			return olditem;
		}
		
		public function toArray():Array
		{
			const list:Vector.<Object> = this.list;
			var length:uint = list.length;
			const arr:Array = new Array(length);
			var i:uint = 0;
			
			while(i < length)
				arr[i] = list[i ++];
			
			return arr;
		}
	}
}