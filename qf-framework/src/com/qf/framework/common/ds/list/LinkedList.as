package com.qf.framework.common.ds.list {

import com.qf.framework.common.ds.Collection;
import com.qf.framework.common.ds.List;
import com.qf.framework.common.ds.Iterator;

/**
 * 实现所有IList操作，并且允许所有元素（包括 null）。除了实现 List 接口外，LinkedList 类还提供了 getFirst(),removeFirst() 等高效数据操作方法。
 * 这些操作允许将链接列表用作堆栈、队列或双端队列 (deque)。
 * 所有操作都是按照双重链接列表的需要执行的。在列表中编索引的操作将从开头或结尾遍历列表。
 * <li>注意:随机访问性能较差,如果较多的随机访问操作，请使用ArrayList。</li>
 * <li>注意:LinkedList容量大小是自动增加的，如果你设置合适的大小对性能会有所提高。</li>
 * @see ArrayList
 * @see List
 * @author 青竹
 * @email hui161@gmail.com
 */
public class LinkedList extends AbstractList {

	private var maxSize:int = 50;
	private var linkedEnd:LinkedNode;
	private var initSize:int = 10;
	/**
	 *@private
	 */
	internal var _head:LinkedNode;
	/**
	 *@private
	 */
	internal var _tail:LinkedNode;

	/**
	 * 构造一个包含所给参数据中的元素的列表，这些元素按其集合的迭代器返回的顺序排列。
	 * @param size 容器在初始化大小(设置合适的容器大小对性能有所提升).
	 * @param arg 元素的列表
	 *
	 */
	public function LinkedList(size:int = 50, ...arg) {
		var l:int = arg.length;
		initSize = size;
		if (l < size) {
			maxSize = size;
		}
		else {
			maxSize = l + size;
		}

		linkedEnd = _tail = _head = new LinkedNode(arg[0]);
		var temp:LinkedNode;
		for (var i:int = 1; i < maxSize; i++) {
			if (i < l) {
				temp = new LinkedNode(arg[i]);
				if (i == l - 1) {
					_tail = temp;
				}
			} else {
				temp = new LinkedNode();
			}
			linkedEnd.next = temp;
			temp.prev = linkedEnd;
			linkedEnd = temp;
		}
		_size = l;
		//this.debug()

	}

	/**
	 *  设置容器最大容量.
	 *  默认最小为50.
	 *
	 */
	public function setMaxSize(size:int):void {
		var n:int = size - maxSize;
		if (n <= 0) {
			return;
		}
		var temp:LinkedNode;
		for (var i:int = 0; i < n; i++) {
			if (linkedEnd.next == null) {
				temp = new LinkedNode();
				linkedEnd.next = temp;
				temp.prev = linkedEnd;
			}
			linkedEnd = linkedEnd.next;
		}
		maxSize = size;
	}

	public function getMaxSize():int {
		return maxSize;
	}

	/**
	 * @inheritDoc
	 */
	override public function add(o:*):Boolean {
		upCheck();
		if (_size == 0) {
			_tail.data = o;
		} else {
			_tail.next.data = o;
			_tail = _tail.next;
		}
		_size++;
		return true;
	}

	private function getNullNode(value:*):LinkedNode {
		var n:LinkedNode = linkedEnd;
		linkedEnd = linkedEnd.prev;
		linkedEnd.next = null;

		n.next = n.prev = null;
		n.data = value;
		return n
	}

	/**
	 * @inheritDoc
	 */
	override public function addAt(index:uint, o:*):Boolean {
		if (index > _size) {
			return false;
		}
		var temp:LinkedNode;
		upCheck();
		//
		if (_size == 0) {
			_head.data = o;
			_size++;
			return true;
		}
		if (index == _size) {
			_tail.next.data = o;
			_tail = _tail.next;
			_size++;
			return true;
		}
		var newNode:LinkedNode = getNullNode(o);
		temp = getNode(index);
		if (temp.prev) {
			temp.prev.next = newNode;
			newNode.prev = temp.prev;
		}
		if (temp == _head) {
			_head = newNode
		}
		temp.prev = newNode;
		newNode.next = temp;
		_size++;
		return true;
	}

	/**
	 * @inheritDoc
	 */
	override public function addAllAt(index:uint, o:Collection):void {
		if (index > _size || o.size() == 0) {
			throw new Error("添加元素失败。");
		}
		var os:int = _size;
		var temp:LinkedNode;
		var l:int = o.size();
		var d:int = (((l / initSize) >> 0) + 1) * initSize;
		if ((l + _size) >= maxSize) {
			for (var j:int = 0; j < d; j++) {
				if (linkedEnd.next == null) {
					temp = new LinkedNode();
					linkedEnd.next = temp;
					temp.prev = linkedEnd;
				}
				linkedEnd = linkedEnd.next;
			}
			maxSize += d;
		}

		//
		var i:Iterator = o.iterator();
		i.reset();
		temp = _tail.next;
		while (i.hasNext()) {
			temp.data = i.next();
			temp = temp.next;
			_size++
		}

		//
		if (index != os) {
			temp = temp.prev;
			var indexNode:LinkedNode = getNode(index);
			if (indexNode.prev) {
				indexNode.prev.next = _tail.next;
				_tail.next.prev = indexNode.prev;
			}
			if (index == 0) {
				_head = _tail.next;
			}
			_tail.next = temp.next;
			//_tail=_tail.next;

			temp.next = indexNode;
			indexNode.prev = temp;

		} else {
			_tail = temp.prev
		}

	}

	/**
	 * 返回列表中指定位置的元素，此方法慢于ArrayList,用迭代器顺序访问每件元素，比用LinkedList.get()方法快很多。
	 * @param index 要替换的元素的索引
	 * @return 列表中指定位置的元素
	 *
	 */
	override public function get(index:uint):Object {
		var temp:LinkedNode = getNode(index);
		if (temp) {
			return temp.data;
		}
		else {
			return null;
		}
	}

	/**
	 * @inheritDoc
	 */
	override public function indexOf(o:Object):int {
		if (_head.data == o) {
			return 0;
		}
		var i:int = 0;
		var temp:LinkedNode = _head;
		while (temp) {
			if (temp.data === o) {
				return i
			}
			i++;
			temp = temp.next;
		}
		return -1;
	}

	/**
	 * @inheritDoc
	 */
	override public function lastIndexOf(o:Object):int {
		if (_tail.data == o) {
			return _size - 1;
		}
		var i:int = _size - 1;
		var temp:LinkedNode = _tail;
		while (temp) {
			if (temp.data === o) {
				return i
			}
			i--;
			temp = temp.prev;
		}
		return -1;
	}

	/**
	 * @inheritDoc
	 */
	override public function subList(fromIndex:uint, toIndex:uint):List {
		var l:LinkedList = new LinkedList();
		var end:LinkedNode = getNode(toIndex - 1);
		var n:LinkedNode = getNode(fromIndex);
		if (toIndex > fromIndex) {
			while (n != null && n != end.next) {
				l.add(n.data);
				n = n.next;
			}
		}
		return l;
	}

	/**
	 * @inheritDoc
	 */
	override public function removeAt(index:uint):Object {
		if (index >= _size) {
			return null;
		}
		var temp:LinkedNode = getNode(index);
		var d:* = temp.data;
		_size--;
		if (_size == 0) {
			temp.data = null;
			downCheck();
			return d;
		}
		if (temp.prev) {
			temp.prev.next = temp.next;
		}
		if (temp.next) {
			temp.next.prev = temp.prev;
		}
		if (temp == _head) {
			_head = temp.next;
		}
		if (temp == _tail) {
			_tail = temp.prev;
		}

		linkedEnd.next = temp;
		temp.prev = linkedEnd;
		linkedEnd = temp;
		temp.next = null;
		temp.data = null;
		downCheck();
		return d;
	}

	private function getNode(index:uint):LinkedNode {
		if (_size <= 0) {
			return null;
		}
		if (index >= _size) {
			return _tail;
		}
		var i:int = 0;
		var temp:LinkedNode = _head;
		while (i < _size) {

			if (i == index) {
				break;
			}
			temp = temp.next;
			i++;
		}

		return temp;
	}

	/**
	 * @inheritDoc
	 */
	override public function replace(index:uint, o:Object):Object {
		if (index < 0 || index >= _size) {
			return null
		}
		var temp:LinkedNode = getNode(index);
		if (temp) {
			var d:* = temp.data;
			temp.data = o;
			return d;
		}
		return null;
	}

	/**
	 * @inheritDoc
	 */
	override public function clear():void {
		_head = _tail = null;
		_size = 0;
		maxSize = initSize;
		linkedEnd = _tail = _head = new LinkedNode();
		var temp:LinkedNode;
		for (var i:int = 1; i < maxSize; i++) {
			temp = new LinkedNode();

			linkedEnd.next = temp;
			temp.prev = linkedEnd;
			linkedEnd = temp;
		}
	}

	/**
	 * @inheritDoc
	 */
	override public function iterator():Iterator {
		return new LinkedListIterator(this);
	}

	/**
	 * @inheritDoc
	 */
	override public function iteratorAt(index:uint):Iterator {
		return new LinkedListIterator(this, getNode(index), index);
	}

	/**
	 * @inheritDoc
	 */
	override public function remove(o:Object):Object {
		var temp:LinkedNode = _head;
		while (temp) {
			if (temp.data == o) {
				_size--;
				if (_size == 0) {
					temp.data = null;
					downCheck();
					return o;
				}
				if (temp.prev) {
					temp.prev.next = temp.next;
				}
				if (temp.next) {
					temp.next.prev = temp.prev;
				}
				if (temp == _head) {
					_head = temp.next;
				}
				if (temp == _tail) {
					_tail = temp.prev;
				}

				linkedEnd.next = temp;
				temp.prev = linkedEnd;
				linkedEnd = temp;
				temp.next = null;
				temp.data = null;
				downCheck();
				return o;
			}
			temp = temp.next;
		}
		return null;
	}

	/**
	 * 在指定的Iterator后插入一个元素
	 * @param itr 指定位置的迭代器.
	 * @param obj 要插入的元素
	 *
	 * @return
	 */
	public function insertBeforeByIterator(itr:LinkedListIterator, obj:*):void {
		//check
		upCheck();

		var node:LinkedNode = itr.currentNode;
		var data:LinkedNode = this.getNullNode(obj);

		if (node != _head) {
			node.prev.next = data;
			data.prev = node.prev;

		} else {
			_head = data;
		}
		data.next = node;
		node.prev = data;
		_size++;
	}

	private function upCheck():void {
		var temp:LinkedNode;
		if (_size == maxSize) {
			for (var i:int = 0; i < initSize; i++) {
				if (linkedEnd.next == null) {
					temp = new LinkedNode();
					linkedEnd.next = temp;
					temp.prev = linkedEnd;
				}
				linkedEnd = linkedEnd.next;
			}
			maxSize += initSize;
		}
	}

	private function downCheck():void {
		var m:int = ((_size / initSize >> 0) + 2) * initSize;
		if (maxSize <= m) {
			return;
		}
		var c:LinkedNode = _head;
		var i:int = 0;
		while (c && i != m) {
			c = c.next;
			i++;
		}
		if (c) {
			this.linkedEnd = c;
			c.next = null;
		}

		maxSize = m;

	}

	/**
	 * 在指定的Iterator前插入一个元素.
	 *
	 * @param itr 指定位置的迭代器.
	 * @param obj 要插入的元素
	 *
	 * @return
	 */
	public function insertAfterByIterator(itr:LinkedListIterator, obj:*):void {
		//check
		///
		upCheck();

		var node:LinkedNode = itr.currentNode;
		var data:LinkedNode = this.getNullNode(obj);

		if (node != _tail) {
			node.next.prev = data;
			data.next = node.next;

		} else {
			_tail = data;
		}
		data.prev = node;
		node.next = data;
		_size++;
	}

	/**
	 *在列表的最后位置上添加一个元素 ,比addAt(size()-1,"data")快很多.
	 * @param data 数据.
	 */
	public function addAtLast(data:*):void {
		//check
		upCheck();
		//
		if (_size == 0) {
			_size++;
			_head.data = data;
			return;
		}
		_tail.next.data = data;
		_tail = _tail.next;
		_size++
	}

	/**
	 *在列表的最前的位置上添加一个元素 ,比addAt(0,"data")快.
	 * @param data 数据.
	 */
	public function addAtFirst(data:*):void {
		//check
		var temp:LinkedNode;
		upCheck();
		///
		if (_size == 0) {
			_size++;
			_head.data = data;
			return;
		}
		temp = this.getNullNode(data);
		_size++;
		_head.prev = temp;
		temp.next = _head;
		_head = temp;
	}

	/**
	 *获取列表中最后一个元素
	 * @return
	 *
	 */
	public function getLast():* {
		return _tail.data;
	}

	/**
	 *获取列表中第一个元素
	 * @return
	 *
	 */
	public function getFirst():* {
		return _head.data;
	}

	/**
	 * 移除并返回列表中最后一个元素.
	 * @return 最后一个元素.
	 *
	 */
	public function removeLast():* {
		if (_size <= 0) {
			return null;
		}
		var d:* = _tail.data;
		if (_tail.prev != null) {
			_tail.data = null;
			_tail = _tail.prev;
			if (_size == 1) {
				_head = _tail;
			}
		}
		_size--;
		downCheck();
		return d;
	}

	/**
	 *移除并返回列表中第一个元素.
	 * @return 第一个元素.
	 *
	 */
	public function removeFirst():* {
		if (_size <= 0) {
			return null;
		}
		var d:* = _head.data;

		var h:LinkedNode = _head.next;
		linkedEnd.next = _head;

		_head.prev = linkedEnd;
		linkedEnd = _head;

		_head.next = null;
		_head.data = null;

		if (h) {
			h.prev = null;
		}

		if (_size == 1) {
			_tail = h
		}
		_head = h;
		_size--;
		downCheck();
		return d;
	}

	/**
	 * 反转指定列表中元素的顺序。
	 */
	public function reverse():void {
		var temp:LinkedNode = _head;
		var node:LinkedNode;
		var sentinel:LinkedNode = _tail.next;
		while (temp) {
			node = temp.next;
			temp.next = temp.prev;
			temp.prev = node;
			temp = node;
			if (temp == sentinel) {
				break;
			}
		}

		_tail.prev.prev = _head;
		_head.next = _tail.prev;
		_tail.prev = null;

		temp = _head;
		_head = _tail;
		_tail = temp;
	}

	/**
	 *在指定列表的指定位置处交换元素。
	 * @param i  要交换的一个元素的索引。
	 * @param j 要交换的另一个元素的索引。
	 *
	 */
	public function swap(i:uint, j:uint):void {
		var node1:LinkedNode = getNode(i);
		var node2:LinkedNode = getNode(j);
		var temp:* = node1.data;
		node1.data = node2.data;
		node2.data = temp;
	}

	/**
	 * 在指定位置修改值.
	 * @param i 位置
	 * @param data 值
	 * @return 如果修改成功则返回true.
	 */
	public function modify(i:int, data:*):Boolean {
		var node:LinkedNode = getNode(i).data;
		if (node) {
			node.data = data;
			return true;
		}
		return false;
	}

	/**
	 *@private
	 *
	 */
	public function debug():void {
		var show:String = "";
		var c:LinkedNode = _head;
		var temp:*;
		while (c) {
			if (c.data != null) {
				temp = c.data
			} else {
				temp = "a"
			}
			show += temp;
			if (c == _head) {
				show += "(head)";
			}
			if (c == _tail) {
				show += "(tail)";
			}
			if (c == this.linkedEnd) {
				show += "{end}-"
			}
			show += "-";

			c = c.next
		}
		trace("show:", show)
	}
}
}