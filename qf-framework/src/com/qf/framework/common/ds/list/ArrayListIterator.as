package com.qf.framework.common.ds.list {
import com.qf.framework.common.ds.error.IllegalStateError;

/**
 * ArrayList的迭代器。
 * @author 青竹
 * @email hui161@gmail.com
 */
public class ArrayListIterator implements ListIterator {
	private var _arrayList:ArrayList;
	private var index:uint = 0;
	private var lastIndex:int = -1;

	public function ArrayListIterator(list:ArrayList, index:int = 0) {
		_arrayList = list;
		this.index = index;
	}

	/**
	 * @inheritDoc
	 */
	public function hasNext():Boolean {
		return (index < _arrayList.size())

	}

	/**
	 * @inheritDoc
	 */
	public function next():* {
		lastIndex = index;
		return _arrayList.get(index++);
	}

	/**
	 * @inheritDoc
	 */
	public function reset():void {
		index = 0;
	}

	/**
	 * @inheritDoc
	 */
	public function add(o:*):void {
		lastIndex = -1;
		_arrayList.addAt(index, o);
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	public function hasPrevious():Boolean {
		return index >= 0 && _arrayList.size() > 0 && index - 1 < _arrayList.size();
	}

	/**
	 * @inheritDoc
	 */
	public function nextIndex():int {
		return index
	}

	/**
	 * @inheritDoc
	 */
	public function previous():* {
		lastIndex = index;
		return _arrayList.get(index--);
	}

	/**
	 * @inheritDoc
	 */
	public function previousIndex():int {
		return index;
	}

	/**
	 * @inheritDoc
	 */
	public function remove():void {
		if (lastIndex >= 0) {
			_arrayList.removeAt(lastIndex);
			lastIndex = -1
		} else {
			throw new IllegalStateError();
		}
	}

	/**
	 * @inheritDoc
	 */
	public function replace(v:Object):void {
		_arrayList.replace(index, v);
	}
}
}