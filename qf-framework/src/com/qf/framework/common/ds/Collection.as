package com.qf.framework.common.ds {

/**
 * ICollection 表示一组对象。
 * @author 青竹
 * @email hui161@gmail.com
 */
public interface Collection {
	/**
	 * 确保此 collection 包含指定的元素。
	 * @param o 确定此 collection 中是否存在的元素。
	 * @return 如果此 collection 随调用的结果而发生改变，则返回 true
	 *
	 */
	function add(o:*):Boolean

	/**
	 * 将指定 collection 中的所有元素都添加到此 collection 中。
	 * @param c 要插入到此 collection 的元素。
	 *
	 */
	function addAll(c:Collection):void

	/**
	 * 除此 collection 中的所有元素
	 */
	function clear():void

	/**
	 * 如果此 collection 包含指定的元素，则返回 true。
	 * @param o 测试在此 collection 中是否存在的元素。
	 * @return 如果此 collection 包含指定的元素，则返回 true
	 *
	 */
	function contains(o:Object):Boolean

	/**
	 * 如果此 collection 包含指定 collection 中的所有元素，则返回 true。
	 * @param c 将检查是否包含在此 collection 中的 collection。
	 * @return 如果此 collection 包含指定 collection 中的所有元素，则返回 true
	 *
	 */
	function containsAll(c:Collection):Boolean

	/**
	 * 比较此 collection 与指定对象是否相等。
	 * @param o 要与此 collection 进行相等性比较的对象。
	 * @return 如果指定对象与此 collection 相等，则返回 true
	 *
	 */
	function equals(o:Object):Boolean

	/**
	 * 如果此 collection 不包含元素，则返回 true。
	 * @return 如果此 collection 包含指定的元素，则返回 true
	 *
	 */
	function isEmpty():Boolean

	/**
	 * 返回在此 collection 的元素上进行迭代的迭代器。
	 * @return  在此 collection 的元素上进行迭代的 Iterator
	 * @see Iterator
	 *
	 */
	function iterator():Iterator

	/**
	 * 从此 collection 中移除指定元素的单个实例，如果存在的话
	 * @param o  要从此 collection 中移除的元素（如果存在）。
	 * @return 如果此 collection 随调用的结果而发生改变，则返回 true
	 *
	 */
	function remove(o:Object):Object

	/**
	 * 移除此 collection 中那些也包含在指定 collection 中的所有元素
	 * @param c 要从此 collection 移除的元素。
	 * @return 如果此 collection 随调用的结果而发生改变，则返回 true
	 *
	 */
	function removeAll(c:Collection):Boolean

	/**
	 * 仅保留此 collection 中那些也包含在指定 collection 的元素
	 * @param c 保留在此 collection 中的元素。
	 * @return
	 *
	 */
	function retainAll(c:Collection):Boolean

	/**
	 * 返回此 collection 中的元素数。
	 * @return
	 *
	 */
	function size():uint

	/**
	 * 返回包含此 collection 中所有元素的数组。
	 * @return
	 *
	 */
	function toArray():Array

}
}