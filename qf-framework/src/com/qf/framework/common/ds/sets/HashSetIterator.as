package com.qf.framework.common.ds.sets {
import com.qf.framework.common.ds.Iterator;

/**
 * HashSet迭代器.
 * @author 青竹
 * @email hui161@gmail.com
 */
public class HashSetIterator implements Iterator {
	private var _set:HashSet;
	private var _array:Array;
	private var index:int = 0;

	public function HashSetIterator(set:HashSet) {
		_set = set;
		_array = set.toArray();
	}

	/**
	 * @inheritDoc
	 */
	public function hasNext():Boolean {
		return index < _set.size();
	}

	/**
	 * @inheritDoc
	 */
	public function next():* {
		return _array[index++];
	}

	/**
	 * @inheritDoc
	 */
	public function reset():void {
		_array = _set.toArray();
		index = 0
	}
}
}