package com.qf.framework.common.ds.map {
import com.qf.framework.common.ds.Iterator;

/**
 * HashMap迭代器.
 * @author 青竹
 * @email hui161@gmail.com
 */
public class HashMapIterator implements Iterator {
	private var iterator:Iterator;

	public function HashMapIterator(map:HashMap) {

		iterator = map.entrySet().iterator();
	}

	/**
	 * @inheritDoc
	 */
	public function hasNext():Boolean {
		return iterator.hasNext();
	}

	/**
	 * @inheritDoc
	 */
	public function next():* {
		return MapEntry(iterator.next()).value;
	}

	/**
	 * @inheritDoc
	 */
	public function reset():void {
		iterator.reset()
	}
}
}