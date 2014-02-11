package com.qf.framework.common.ds.sets {
import com.qf.framework.common.ds.AbstractCollection;
import com.qf.framework.common.ds.Set;
import com.qf.framework.common.ds.Iterator;
import com.qf.framework.common.ds.ds_namespace;

import flash.utils.Dictionary;

/**
 * 基于Dictionary与链表的 ISet 接口的实现,具有hashMap的查询速度，优势在于迭代的速度非常快。
 * @author hui161@gmail.com
 * @author 青竹
 * @email hui161@gmail.com
 */
public class LinkedHashSet extends AbstractCollection implements Set {
	use namespace ds_namespace;

	ds_namespace var _head:Node;
	ds_namespace var _tail:Node;

	private var _keys:Dictionary;

	public function LinkedHashSet() {
		_keys = new Dictionary(true);

	}

	/**
	 * @inheritDoc
	 */
	override public function add(o:*):Boolean {
		if (_keys.hasOwnProperty(o)) {
			return false;
		}
		var temp:Node = new Node(o);
		if (!_head) {
			_tail = _head = temp;
		} else {
			_tail.next = temp;
			temp.prev = _tail;
			_tail = temp;
		}
		_keys[o] = temp;
		_size++;
		return true
	}

	/**
	 * @inheritDoc
	 */
	override public function remove(o:Object):Object {
		if (!(o in _keys)) {
			return null;
		}
		var temp:Node = _keys[o];
		if (_tail == _head) {
			_tail = _head = null;
			delete _keys[o];
			_size--;
			return o;
		}
		if (temp == _head) {
			_head.next.prev = null;
			_head = _head.next;
			delete _keys[o];
			_size--;
			return o
		}
		if (temp == _tail) {
			_tail.prev.next = null;
			delete _keys[o];
			_tail = _tail.prev;
			_size--;
			return o
		}
		temp.prev.next = temp.next;
		temp.next.prev = temp.prev;
		_size--;
		delete _keys[o];
		return o;
	}

	/**
	 * @inheritDoc
	 */
	override public function contains(o:Object):Boolean {
		return o in _keys;
	}

	/**
	 * @inheritDoc
	 */
	override public function clear():void {
		_head = _tail = null;
		_keys = new Dictionary(true);
		_size = 0;
	}

	/**
	 * @inheritDoc
	 */
	override public function iterator():Iterator {
		return new LinkedSetIterator(this)
	}
}
}
