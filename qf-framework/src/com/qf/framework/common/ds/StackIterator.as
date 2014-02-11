package com.qf.framework.common.ds {
/**
 *
 * @author 青竹
 * @email hui161@gmail.com
 */
public class StackIterator implements Iterator {
	private var array:Array;
	private var index:int = 0;
	private var _stack:ArrayStack;

	public function StackIterator(stack:ArrayStack) {
		array = stack.toArray();
		index = 0;
		_stack = stack;
	}

	/**
	 * @inheritDoc
	 */
	public function hasNext():Boolean {
		return index < array.length;
	}

	/**
	 * @inheritDoc
	 */
	public function next():* {
		return array[index++];
	}

	/**
	 * @inheritDoc
	 */
	public function reset():void {
		index = 0;
		array = _stack.toArray();
	}
}
}