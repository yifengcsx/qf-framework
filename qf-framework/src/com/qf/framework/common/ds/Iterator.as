package com.qf.framework.common.ds {
/**
 * 对集合进行迭代的迭代器。
 * @author 青竹
 * @email hui161@gmail.com
 */
public interface Iterator {
	/**
	 * 如果仍有元素可以迭代，则返回 true。
	 * @return
	 *
	 */
	function hasNext():Boolean;

	/**
	 * 返回迭代的下一个元素。
	 * @return
	 *
	 */
	function next():*;

	/**
	 * 从迭代器指向的集合中移除迭代器返回的第一个元素.
	 *
	 */
	function reset():void;
}
}