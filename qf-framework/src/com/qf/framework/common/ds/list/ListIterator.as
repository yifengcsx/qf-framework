package com.qf.framework.common.ds.list {
import com.qf.framework.common.ds.Iterator;

/**
 *系列表迭代器，允许程序员按任一方向遍历列表、迭代期间修改列表，并获得迭代器在列表中的当前位置。ListIterator 没有当前元素；
 * 它的光标位置 始终位于调用 previous() 所返回的元素和调用 next() 所返回的元素之间。在长度为 n 的列表中，有 n+1 个有效的索引值，从 0 到 n（包含）。
 * <li>注意，remove() 和 replace(Object) 方法不是 根据游标位置定义的；它们是根据对调用 next() 或 previous() 所返回的最后一个元素的操作定义的。 </li>
 * @author 青竹
 * @email hui161@gmail.com
 */
public interface ListIterator extends Iterator {
	/**
	 * 将指定的元素插入列表
	 * @param o
	 *
	 */
	function add(o:*):void;

	/**
	 *如果以反向遍历列表，列表迭代器有多个元素，则返回 true。
	 * @return
	 *
	 */
	function hasPrevious():Boolean;

	/**
	 * 返回对 next 的后续调用所返回元素的索引。
	 * @return
	 *
	 */
	function nextIndex():int;

	/**
	 * 返回列表中的前一个元素。
	 * @return
	 *
	 */
	function previous():*;

	/**
	 *返回对 previous 的后续调用所返回元素的索引。
	 * @return
	 *
	 */
	function previousIndex():int;

	/**
	 * 从列表中移除由 next 或 previous 返回的最后一个元素
	 *
	 */
	function remove():void;

	/**
	 *用指定元素替换 next 或 previous 返回的最后一个元素
	 * @param v
	 *
	 */
	function replace(v:Object):void
}
}