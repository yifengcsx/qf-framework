package com.qf.framework.common.ds.list {
import com.qf.framework.common.ds.Collection;
import com.qf.framework.common.ds.List;
import com.qf.framework.common.ds.Iterator;

/**
 * List 接口的大小可变数组的实现,实现了所有可选列表操作，并允许包括 null 在内的所有元素。
 * 除了实现 List 接口外，此类还提供一些实用的方法。
 * @author 青竹
 * @email hui161@gmail.com
 */
public class ArrayList extends AbstractList //implements IQueue
{
	internal var _array:Array;

	public function ArrayList(...arg) {
		_size = arg.length;
		_array = arg.slice(0);
	}

	/**
	 * @inheritDoc
	 */
	override public function add(o:*):Boolean {
		return _array[_size++] = o;
	}

	/**
	 * @inheritDoc
	 */
	override public function get(index:uint):Object {
		return _array[index];
	}

	/**
	 * @inheritDoc
	 */
	override public function clear():void {
		_array = [];
		_size = 0;
	}

	/**
	 * @inheritDoc
	 */
	override public function iterator():Iterator {
		return new ArrayListIterator(this);
	}

	/**
	 * @inheritDoc
	 */
	override public function remove(o:Object):Object {
		var i:int = _array.indexOf(o);
		if (i < 0) {
			return null
		}
		_size--;
		return _array.splice(i, 1);
	}

//		public function enqueue(obj:*):Boolean
//		{
//			_size++
//			return _array.push(obj)>0;
//		}
//		/**
//		 * @inheritDoc
//		 */
//		public function dequeue():*
//		{
//			if(_size<=0) return null;
//			_size--
//			return _array.shift();
//		}
//
//		public function peek():*
//		{
//			return _array[0];
//		}
	/**
	 * @inheritDoc
	 */
	override public function addAt(index:uint, o:*):Boolean {
		if (index > _size) {
			return false;
		}
		/**实现一
		 for(var i:int=_size;i>index;i--){
			    _array[i]=_array[i-1];
			}
		 _array[index]=o;
		 ***/
		_array.splice(index, 0, o);
		_size++;
		return true;
	}

	/**
	 * @inheritDoc
	 */
	override public function addAllAt(index:uint, o:Collection):void {
		if (index > _size) {
			throw new Error("溢出");
		}
		var os:uint = o.size();
		var newSize:uint = os + _size;
		var c:int = os + index - 1;
		for (var i:int = newSize - 1; i > c; i--) {
			_array[i] = _array[i - os];
		}

		var itr:Iterator = o.iterator();
		var ir:uint = index;
		while (itr.hasNext()) {
			_array[ir++] = itr.next();
		}
		_size = newSize;
	}

	/**
	 * @inheritDoc
	 */
	override public function indexOf(o:Object):int {
		return _array.indexOf(o);
	}

	/**
	 * @inheritDoc
	 */
	override public function lastIndexOf(o:Object):int {
		return _array.lastIndexOf(o, _size - 1);
	}

	/**
	 * @inheritDoc
	 */
	override public function subList(fromIndex:uint, toIndex:uint):List {
		var list:ArrayList = new ArrayList();
		var datas:Array = _array.slice(fromIndex, toIndex);
		for (var i:int = 0; i < datas.length; i++) {
			list.add(datas[i]);
		}
		return list;
	}

	/**
	 * @inheritDoc
	 */
	override public function removeAt(index:uint):Object {
		if (index >= _size) {
			return null;
		}
		_size--;

		var o:* = _array[index];
		_array.splice(index, 1);
		return o;
	}

	/**
	 * @inheritDoc
	 */
	override public function replace(index:uint, o:Object):Object {
		_array[index] = o;
		return o;
	}

	/**
	 * @inheritDoc
	 */
	override public function iteratorAt(index:uint):Iterator {
		if (index < 0 || index > _size) {
			return null;
		}
		return new ArrayListIterator(this, index);
	}

	/**
	 *获取列表中最后一个元素
	 * @return
	 *
	 */
	public function getLast():* {
		return _array[_size - 1];
	}

	/**
	 *获取列表中第一个元素
	 * @return
	 *
	 */
	public function getFirst():* {
		return _array[0];
	}

	/**
	 * 移除并返回列表中最后一个元素.
	 * @return 最后一个元素.
	 *
	 */
	public function removeLast():* {
		if (_size == 0) {
			return null;
		}
		_size--;
		return _array.pop();
	}

	/**
	 *移除并返回列表中第一个元素.
	 * @return 第一个元素.
	 *
	 */
	public function removeFirst():* {
		if (_size == 0) {
			return null;
		}
		_size--;
		return _array.shift();
	}

	/**
	 * 反转指定列表中元素的顺序。
	 */
	public function reverse():void {
		_array.reverse();
	}

	/**
	 *在指定列表的指定位置处交换元素。
	 * @param i  要交换的一个元素的索引。
	 * @param j 要交换的另一个元素的索引。
	 *
	 */
	public function swap(i:uint, j:uint):void {
		var d:* = _array[i];
		_array[i] = _array[j];
		_array[j] = d;
	}

	/**
	 * 在指定位置修改值.
	 * @param i 位置.
	 * @param data 值.
	 * @return 如果修改成功则返回true.
	 */
	public function modify(i:uint, data:*):Boolean {
		if (i >= _size) {
			return false;
		}
		_array[i] = data;
		return true;
	}

	public function debug():void {
		trace(this)
	}
}
}