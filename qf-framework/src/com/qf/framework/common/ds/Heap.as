package com.qf.framework.common.ds {
/**
 * 基于Array堆的实现。
 * @author 青竹
 * @email hui161@gmail.com
 */
public class Heap extends AbstractCollection {

	private var _data:Array;
	private var compare:Function;

	public function Heap() {
		_data = [];
		compare = function (a:*, b:*):Boolean { return a < b; };
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
	 * 移除堆的最上面一个元素
	 * @return
	 *
	 */
	public function removeTop():* {
		if (_size <= 0) {
			return null
		}
		var obj:* = _data[1];
		_data[1] = _data[_size];
		delete _data[_size--];
		trickleDown();
		return obj;
	}

	/**
	 * @inheritDoc
	 */
	override public function add(v:*):Boolean {
		_data[++_size] = v;
		trickleUp();
		return true
	}

	/**
	 * @inheritDoc
	 */
	override public function contains(data:Object):Boolean {
		return _data.indexOf(data) != -1;
	}

	/**
	 * @inheritDoc
	 */
	override public function clear():void {
		_data = [];
		_size = 0;
	}

	private function trickleDown():void {
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
						return;
					}
				} else {
					if (compare(_data[left], _data[root])) {
						temp = _data[left];
						_data[left] = _data[root];
						_data[root] = temp;
						root = left;
					} else {
						return
					}
				}
			} else {
				if (compare(_data[left], _data[root])) {
					temp = _data[left];
					_data[left] = _data[root];
					_data[root] = temp;
					root = left;
				} else {
					return;
				}
			}
		}
	}

	private function trickleUp():void {
		var cp:* = _data[_size];
		var curr:int = _size;
		var parent:int = curr >> 1;

		var tmp:*;
		while (curr > 1) {
			tmp = _data[parent];
			if (compare(cp, tmp)) {
				_data[curr] = tmp;
				curr = parent;
				parent >>= 1;
			} else {
				break;
			}
		}
		_data[curr] = cp
	}

	/**
	 * @inheritDoc
	 */
	override public function toArray():Array {
		return _data.slice(1, _size + 1);
	}
}
}