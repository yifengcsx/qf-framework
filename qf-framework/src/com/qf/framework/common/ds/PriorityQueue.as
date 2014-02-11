package com.qf.framework.common.ds {
import com.qf.framework.common.ds.error.UnsupportedOperationError;

/**
 *一个基于优先级堆的极大优先级队列。此队列按照在构造时所指定的顺序对元素排序，既可以根据元素的自然顺序 来指定排序，
 * 优先级队列不允许 null 元素。依靠自然排序的优先级队列还不允许插入不可比较的对象。
 * 此队列的头是按指定排序方式的最小 元素。
 * remove(o:*)和iterator()，retainAll()方法不兼容。
 * @author 青竹
 * @email hui161@gmail.com
 */
public class PriorityQueue extends AbstractCollection implements Queue {
	private var _data:Array;
	private var compare:Function;

	public function PriorityQueue() {
		_data = [];
		compare = function (a:*, b:*):Boolean { return a > b; };
	}

	/**
	 * 设置比较运算的逻辑
	 * @param fun 比较运算的逻辑函数，此函数返回true与false;
	 *
	 */
	public function setCompareFunction(fun:Function):void {
		compare = fun;
	}

	/**
	 * 不支持此方法。请使用dequeue()方法进行移除。
	 * @param o
	 * @return
	 *
	 */
	override public function remove(o:Object):Object {
		throw new UnsupportedOperationError();
	}

	/**
	 * 不支持此方法。请使用dequeue()方法进行移除。
	 *
	 */
	override public function removeAll(c:Collection):Boolean {
		throw new UnsupportedOperationError();
	}

	/**
	 * 不支持此方法。请使用dequeue()方法进行移除。
	 *
	 */
	override public function retainAll(c:Collection):Boolean {
		throw new UnsupportedOperationError();
	}

	/**
	 * @inheritDoc
	 *
	 */
	override public function contains(o:Object):Boolean {
		return _data.indexOf(o) > 0;
	}

	/**
	 * 移除堆的最上面一个元素
	 * @return
	 *
	 */
	public function dequeue():* {
		if (_size <= 0) {
			return null
		}
		var obj:* = _data[1];
		_data[1] = _data[_size];
		delete _data[_size--];
		var temp:*;
		var root:int = 1;
		var left:int;
		var right:int;
		while (root < _size) {
			left = root << 1;
			right = left + 1;
			if (right <= _size) {
				if (compare(_data[right], _data[left])) {
					if (compare(_data[right], _data[root])) {
						temp = _data[right];
						_data[right] = _data[root];
						_data[root] = temp;
						root = right
					} else {
						return obj;
					}
				} else {
					if (compare(_data[left], _data[root])) {
						temp = _data[left];
						_data[left] = _data[root];
						_data[root] = temp;
						root = left;
					} else {
						return obj
					}
				}
			} else {
				if (compare(_data[left], _data[root])) {
					temp = _data[left];
					_data[left] = _data[root];
					_data[root] = temp;
					root = left;
				} else {
					return obj;
				}
			}
		}
		return obj;
	}

	/**
	 *  入队
	 * @param v 入队的值，不能为空(null)。
	 * @return
	 *
	 */
	public function enqueue(v:*):Boolean {
		if (v == null) {
			return false;
		}
		_data[++_size] = v;
		var cp:* = _data[_size];
		var curr:int = _size;
		var parent:int = curr >> 1;

		var tmp:*;
		while (curr > 1) {
			tmp = _data[parent];
			if (compare(cp, tmp) > 0) {
				_data[curr] = tmp;
				curr = parent;
				parent >>= 1;
			} else {
				break;
			}
		}
		_data[curr] = cp;
		return true
	}

	/**
	 * @inheritDoc
	 *
	 */
	override public function add(o:*):Boolean {
		return enqueue(o)
	}

	/**
	 * @inheritDoc
	 *
	 */
	override public function clear():void {
		_size = 0;
		_data = [];
	}

	/**
	 * @inheritDoc
	 *
	 */
	public function peek():* {
		return _data[_size];
	}

	/**
	 * @inheritDoc
	 *
	 */
	override public function toArray():Array {
		return _data.slice(1, _size + 1);
	}
}
}