package com.qf.framework.common.ds {
import com.qf.framework.common.ds.list.LinkedList;

/**
 * IQueue的实现, 队列通常以 FIFO（先进先出）的方式排序各个元素。
 * Queue完全与LinkedList功能相同,仅仅是在概念上的不同,也可以直接用LinkedList取代Queue。
 * @see LinkedList
 * @author 青竹
 * @email hui161@gmail.com
 */
public class LinkedQueue implements Queue {
	private var _linkedList:LinkedList;

	public function LinkedQueue() {
		_linkedList = new LinkedList();
	}

	/**
	 * @inheritDoc
	 */
	public function enqueue(obj:*):Boolean {
		return _linkedList.add(obj);
	}

	/**
	 * @inheritDoc
	 */
	public function dequeue():* {
		return _linkedList.removeFirst();
	}

	/**
	 * @inheritDoc
	 */
	public function peek():* {
		return _linkedList.getFirst();
	}

	/**
	 * @inheritDoc
	 */
	public function add(o:*):Boolean {
		return _linkedList.add(o);
	}

	/**
	 * @inheritDoc
	 */
	public function addAll(c:Collection):void {
		_linkedList.addAll(c)
	}

	/**
	 * @inheritDoc
	 */
	public function clear():void {
		_linkedList.clear();
	}

	/**
	 * @inheritDoc
	 */
	public function contains(o:Object):Boolean {
		return _linkedList.contains(o);
	}

	/**
	 * @inheritDoc
	 */
	public function containsAll(c:Collection):Boolean {
		return _linkedList.containsAll(c);
	}

	/**
	 * @inheritDoc
	 */
	public function equals(o:Object):Boolean {
		return false;
	}

	/**
	 * @inheritDoc
	 */
	public function isEmpty():Boolean {
		return _linkedList.isEmpty();
	}

	/**
	 * @inheritDoc
	 */
	public function iterator():Iterator {
		return _linkedList.iterator();
	}

	/**
	 * @inheritDoc
	 */
	public function remove(o:Object):Object {
		return _linkedList.remove(o);
	}

	/**
	 * @inheritDoc
	 */
	public function removeAll(c:Collection):Boolean {
		return _linkedList.removeAll(c);
	}

	/**
	 * @inheritDoc
	 */
	public function retainAll(c:Collection):Boolean {
		return _linkedList.retainAll(c);
	}

	/**
	 * @inheritDoc
	 */
	public function size():uint {
		return _linkedList.size();
	}

	/**
	 * @inheritDoc
	 */
	public function toArray():Array {
		return _linkedList.toArray();
	}
}
}