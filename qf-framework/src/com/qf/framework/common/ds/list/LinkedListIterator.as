package com.qf.framework.common.ds.list {
import com.qf.framework.common.ds.error.IllegalStateError;

/**
 * LinkedList迭代器。
 * @author 青竹
 * @email hui161@gmail.com
 */
public class LinkedListIterator implements ListIterator {

	internal var _linkList:LinkedList;
	internal var currentNode:LinkedNode;
	private var index:int = 0;
	private var lastIndex:int = -1;

	public function LinkedListIterator(linkedList:LinkedList, node:LinkedNode = null, index:int = 0) {
		_linkList = linkedList;
		this.index = index;
		if (node) {
			currentNode = node;
		}
		else {
			currentNode = linkedList._head;
		}
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	public function hasNext():Boolean {

		return index < _linkList.size();
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	public function next():* {
		var d:* = currentNode.data;
		if (currentNode != _linkList._tail) {
			currentNode = currentNode.next;
		}
		lastIndex = index;
		index++;

		return d;
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	public function reset():void {
		index = 0;
		currentNode = _linkList._head;
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	public function add(o:*):void {
		_linkList.addAt(index, o);
		lastIndex = -1;
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	public function hasPrevious():Boolean {
		return index >= 0 && _linkList.size() > 0 && index - 1 < _linkList.size();
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	public function nextIndex():int {
		return index
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	public function previous():* {

		var d:* = currentNode.data;
		currentNode = currentNode.prev;
		lastIndex = index;
		index--;

		return d;
	}

	/**
	 * 获取当前值，但不移动游标。
	 * @return 当前值。
	 *
	 */
	public function peek():* {
		return currentNode.data;
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	public function previousIndex():int {
		return index;
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	public function remove():void {
		if (lastIndex >= 0) {
			_linkList.removeAt(lastIndex);
			lastIndex = -1
		} else {
			throw new IllegalStateError();
		}
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	public function replace(v:Object):void {
		_linkList.replace(index, v);
	}
}
}