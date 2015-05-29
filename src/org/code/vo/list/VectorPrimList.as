//package org.code.vo.list
//{
//	import org.code.vo.interfaces.IVectorObj;
//	
//	public final class VectorPrimList extends VectorList
//	{
//		public function VectorPrimList(list:Vector.<IVectorObj>, cls:Class)
//		{
//			super(list, cls);
//		}
//	}
//}
//
//
package org.code.vo.list
{
	import flash.events.EventDispatcher;
	
	import mx.collections.IList;
	
	import org.code.vo.Prim;
	
	public final class VectorPrimList extends EventDispatcher implements IList
	{
		private var list:Vector.<Prim>;
		
		public function VectorPrimList(list:Vector.<Prim>)
		{
			this.list = list;
		}
		
		public function get length():int							{return list.length}
		public function addItem(item:Object):void					{list.push(item as Prim)}
		public function addItemAt(item:Object, index:int):void		{list.splice(index, 0, item as Prim)}
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
			list.splice(index,1);
			return olditem;
		}
		
		public function setItemAt(item:Object, index:int):Object
		{
			const olditem:Prim = list[index];
			list[index] = item as Prim;
			return olditem;
		}
		
		public function toArray():Array
		{
			const list:Vector.<Prim> = this.list;
			var length:uint = list.length;
			const arr:Array = new Array(length);
			var i:uint = 0;
			
			while(i < length)
				arr[i] = list[i ++];
			
			return arr;
		}
	}
}


