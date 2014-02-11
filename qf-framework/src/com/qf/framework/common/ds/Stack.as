package com.qf.framework.common.ds {
/**
 * Stack 类表示后进先出（LIFO）的对象堆栈。它提供了通常的 push 和 pop 操作，
 * 以及取栈顶点的 peek 方法 首次创建堆栈时，它不包含数据项。 可以用LinkedList完全取代Stack，两者只是概念上的不同。
 * @author 青竹
 * @email hui161@gmail.com
 */
public interface Stack extends Collection {
	/**
	 * 入栈
	 * @param obj
	 * @return
	 *
	 */
	function push(obj:*):Boolean;

	/**
	 * 出栈
	 * @return
	 *
	 */
	function pop():*

	/**
	 * 返回队头，但是不移除此队列的头，如果此队列为空，则返回 null。
	 * @return
	 *
	 */
	function peek():*
}
}