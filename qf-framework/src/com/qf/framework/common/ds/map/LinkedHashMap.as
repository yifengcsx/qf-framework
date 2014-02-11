package com.qf.framework.common.ds.map {
import com.qf.framework.common.ds.Collection;
import com.qf.framework.common.ds.Iterator;
import com.qf.framework.common.ds.Map;
import com.qf.framework.common.ds.Set;
import com.qf.framework.common.ds.ds_namespace;
import com.qf.framework.common.ds.list.ArrayList;
import com.qf.framework.common.ds.sets.LinkedHashSet;

import flash.utils.Dictionary;

/**
 * 与hashMap相比优点在于迭代时速度非常快,而且是有序的，使用链表维护内部次序.
 * @author 青竹
 * @email hui161@gmail.com
 */
public class LinkedHashMap extends AbstractMap //implements IMap
{
	use namespace ds_namespace;

	ds_namespace var _head:Node;
	ds_namespace var _tail:Node;

	public function LinkedHashMap() {
		_keys = new Dictionary();
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	override public function containsValue(value:Object):Boolean {
		for each (var p:* in _keys) {
			if (p.data === value) {
				return true
			}
		}
		return false;
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	override public function get(key:Object):* {
		return _keys[key].data;
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	override public function put(key:Object, value:Object):void {
		var temp:Node = new Node(value);
		if (key in _keys) {
			_keys[key] = temp;
			return;
		}

		if (!_head) {
			_tail = _head = temp;
		} else {
			_tail.next = temp;
			temp.prev = _tail;
			_tail = temp;
		}
		_keys[key] = temp;
		_size++;
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	override public function putAll(map:Map):void {
		var linkedSet:Set = map.entrySet();
		var i:Iterator = linkedSet.iterator();
		var temp:MapEntry;
		while (i.hasNext()) {
			temp = MapEntry(i.next());
			put(temp.key, temp.value);
		}
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	override public function equals(o:*):Boolean {
		if (!(o is Map)) {
			return false;
		}
		if (Map(o).size() != _size) {
			return false;
		}
		var i:Iterator = Map(o).entrySet().iterator();
		var temp:MapEntry;
		while (i.hasNext()) {
			temp = MapEntry(i.next());
			if (!_keys.hasOwnProperty(temp.key)) {
				return false
			}
			if (_keys[temp.key].data !== temp.value) {
				return false;
			}

		}
		return true;
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	override public function removeByKey(key:*):* {
		if (!_keys.hasOwnProperty(key)) {
			return null;
		}
		var temp:Node = _keys[key];
		if (_tail == _head) {
			_tail = _head = null;
			delete _keys[key];
			_size--;
			return temp.data;
		}
		if (temp == _head) {
			_head.next.prev = null;
			_head = _head.next;
			delete _keys[key];
			_size--;
			return temp.data;
		}
		if (temp == _tail) {
			_tail.prev.next = null;
			delete _keys[key];
			_tail = _tail.prev;
			_size--;
			return temp.data;
		}
		temp.prev.next = temp.next;
		temp.next.prev = temp.prev;
		_size--;
		delete _keys[key];
		return temp.data;
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	override public function entrySet():Set {
		var set:Set = new LinkedHashSet();
		for (var i:* in _keys) {
			set.add(new MapEntry(i, _keys[i].data))
		}
		return set;
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	override public function getAllValue():Collection {
		var array:ArrayList = new ArrayList();
		for each (var p:* in _keys) {
			array.add(p.data);
		}
		return array;
	}

	/**
	 * 对Map中的值进行迭代，HashMap的迭代速度远不如LinkedHashMap.
	 * @return
	 *
	 */
	public function iterator():LinkedHashMapIterator {
		return new LinkedHashMapIterator(this);
	}

}
}
