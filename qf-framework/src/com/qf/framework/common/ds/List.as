package com.qf.framework.common.ds {
import com.qf.framework.common.ds.list.ListIterator;

/**
 * 有序的 collection。
 * 此接口的用户可以对列表中每个元素的插入位置进行精确地控制。
 * 用户可以根据元素的整数索引（在列表中的位置）访问元素，并搜索列表中的元素。
 * @author 青竹
 * @email hui161@gmail.com
 */
public interface List extends Collection {
	/**
	 *向列表的尾部追加指定的元素
	 * @param index
	 * @param o
	 * @return
	 *
	 */
	function addAt(index:uint, o:*):Boolean;

	/**
	 * 将指定 collection 中的所有元素都插入到列表中的指定位置
	 * @param index 要在其中插入指定元素处的索引
	 * @param o 要插入的元素
	 * @return
	 *
	 */
	function addAllAt(index:uint, o:Collection):void;

	/**
	 * 返回列表中指定位置的元素
	 * @param index 要替换的元素的索引
	 * @return 列表中指定位置的元素
	 *
	 */
	function get(index:uint):Object

	/**
	 * 返回列表中首次出现指定元素的索引，如果列表不包含此元素，则返回 -1。
	 * @param o 要搜索的元素。
	 * @return 返回指定元素的索引，如果列表不包含该元素，则返回 -1。
	 *
	 */
	function indexOf(o:Object):int;

	/**
	 * 返回列表中最后出现指定元素的索引，如果列表不包含此元素，则返回 -1。
	 * @param o 要搜索的元素
	 * @return 返回列表中最后出现指定元素的索引，如果列表不包含此元素，则返回 -1。
	 *
	 */
	function lastIndexOf(o:Object):int

	/**
	 * 返回列表中元素的列表迭代器（以正确的顺序），从列表的指定位置开始。指定的索引指出会由 next 方法的初始调用所返回的首个元素。previous 方法的初始调用会返回索引比指定索引少 1 的元素。
	 * @param fromIndex subList 的低端(包括)
	 * @param toIndex 的高端(不包括)
	 * @return 列表中指定范围的IList
	 *
	 */
	function subList(fromIndex:uint, toIndex:uint):List

	/**
	 *移除指定位置的元素。将所有的后续元素向左移动（将其索引减 1）。返回从列表中移除的元素。
	 * @param index 要移除的元素的索引
	 * @return 以前在指定位置的元素。
	 *
	 */
	function removeAt(index:uint):Object;

	/**
	 *用指定元素替换列表中指定位置的元素
	 * @param index 要替换的元素的索引
	 * @param o 要在指定位置存储的元素
	 * @return 以前在指定位置的元素
	 *
	 */
	function replace(index:uint, o:Object):Object

	/**
	 * 返回列表中元素的列表迭代器（以正确的顺序），从列表的指定位置开始。指定的索引指出会由 next 方法的初始调用所返回的首个元素。previous 方法的初始调用会返回索引比指定索引少 1 的元素。
	 *  @param index 从列表迭代器返回的首个元素的索引
	 *  @return 列表中元素的列表迭代器，从列表中的指定位置开始。
	 *
	 */
	function iteratorAt(index:uint):Iterator

	/**
	 * 返回列表中元素的列表迭代器
	 * @return 列表中元素的列表迭代器
	 *
	 */
	function listIterator():ListIterator;

	/**
	 * 返回列表中元素的列表迭代器，从列表的指定位置开始。指定的索引指出会由 next 方法的初始调用所返回的首个元素。previous 方法的初始调用会返回索引比指定索引少 1 的元素。
	 * @param index 从列表迭代器返回的首个元素的索引
	 * @return 列表中元素的列表迭代器（以正确的顺序），从列表中的指定位置开始。
	 *
	 */
	function listIteratorAt(index:int):ListIterator;
}
}