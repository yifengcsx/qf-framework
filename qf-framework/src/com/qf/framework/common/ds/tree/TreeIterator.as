package com.qf.framework.common.ds.tree {
import com.qf.framework.common.ds.Iterator;

/**
 * BinarySearchTree的迭代器。
 * @author 青竹
 * @email hui161@gmail.com
 */
public class TreeIterator implements Iterator {
	private var _array:Array;
	private var index:int = 0;
	private var tree:BinarySearchTree;

	public function TreeIterator(tree:BinarySearchTree) {
		this.tree = tree;
		_array = tree.toArray();
	}

	/**
	 * @inheritDoc
	 */
	public function hasNext():Boolean {
		return index < _array.length;
	}

	/**
	 * @inheritDoc
	 */
	public function next():* {
		return _array[index++];
	}

	/**
	 * @inheritDoc
	 */
	public function reset():void {
		_array = tree.toArray();
		index = 0;
	}
}
}