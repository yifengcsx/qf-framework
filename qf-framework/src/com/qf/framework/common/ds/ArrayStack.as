package com.qf.framework.common.ds {
/**
 * Stack 类表示后进先出（LIFO）的对象堆栈。它提供了通常的 push 和 pop 操作，
 * 以及取栈顶点的 peek 方法,首次创建堆栈时，它不包含数据项。<li> 可以用LinkedList完全取代Stack，二者只有概念上的不同。</li>
 * @author 青竹
 * @email hui161@gmail.com
 */
public class ArrayStack extends AbstractCollection implements Stack {

	internal var _array:Array;

	public function ArrayStack() {
		_array = [];
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	public function push(obj:*):Boolean {
		return _array[_size++] = obj;
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	public function pop():* {
		if (_size == 0) {
			return null;
		}
		_size--;
		return _array.pop();
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	public function peek():* {
		return _array[_size - 1];
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	override public function add(o:*):Boolean {
		return _array[_size++] = o;
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	override public function iterator():Iterator {
		return new StackIterator(this)
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	override public function addAll(c:Collection):void {
		var i:Iterator = c.iterator();
		while (i.hasNext()) {
			_array[_size++] = i.next();
		}
	}

	/**
	 * @inheritDoc
	 */
	override public function remove(o:Object):Object {
		var i:int = _array.indexOf(o);
		if (i == -1) {
			return null
		}
		_size--;
		return _array.splice(i, 1);
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	override public function clear():void {
		_size = 0;
		_array = [];
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	override public function contains(o:Object):Boolean {
		return _array.indexOf(o) != -1;
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	override public function containsAll(c:Collection):Boolean {
		var i:Iterator = c.iterator();
		while (i.hasNext()) {
			if (_array.indexOf(i.next()) == -1) {
				return false;
			}
		}
		return true;
	}

	/**
	 *
	 * @inheritDoc
	 *
	 */
	override public function toArray():Array {
		return _array.slice();
	}

}
}