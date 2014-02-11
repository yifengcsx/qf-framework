package com.qf.framework.common.ds {
/**
 * 队列通常以 FIFO（先进先出）的方式排序各个元素。
 * @author 青竹
 * @email hui161@gmail.com
 */
public interface Queue extends Collection {
	/**
	 *将指定的元素插入此队列
	 * @param obj 要插入的元素。
	 * @return 如果可以向此队列添加元素，如果成功返回 true；否则返回 false。
	 *
	 */
	function enqueue(obj:*):Boolean

	/**
	 *移除此队列的头并返回，如果此队列为空，则返回 null。
	 * @return 队列的头。
	 *
	 */
	function dequeue():*;

	/**
	 * 返回队头，但是不移除此队列的头，如果此队列为空，则返回 null。
	 * @return
	 *
	 */
	function peek():*
}
}