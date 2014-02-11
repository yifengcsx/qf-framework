package com.qf.framework.common.ds {
/**
 * 空迭代.
 * @author 青竹
 * @email hui161@gmail.com
 */
public class NullIterator implements Iterator {
	public function NullIterator() {
	}

	/**
	 * @inheritDoc
	 */
	public function hasNext():Boolean {
		return false;
	}

	/**
	 * @inheritDoc
	 */
	public function next():* {
		return null;
	}

	/**
	 * @inheritDoc
	 */
	public function reset():void {
	}
}
}