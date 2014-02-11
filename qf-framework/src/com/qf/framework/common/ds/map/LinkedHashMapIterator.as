package com.qf.framework.common.ds.map {
import com.qf.framework.common.ds.Iterator;
import com.qf.framework.common.ds.ds_namespace;

/**
 * LinkedHashMap迭代器。
 * @author 青竹
 * @email hui161@gmail.com
 */
public class LinkedHashMapIterator implements Iterator {
	use namespace ds_namespace;

	private var _head:Node;
	private var curr:Node;

	public function LinkedHashMapIterator(map:LinkedHashMap) {
		curr = _head = map._head;
	}

	/**
	 * @inheritDoc
	 */
	public function hasNext():Boolean {
		return curr != null;
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	public function next():* {
		var d:* = curr.data;
		curr = curr.next;
		return d;
	}

	/**
	 *@inheritDoc
	 *
	 */
	public function reset():void {
		curr = _head
	}
}
}