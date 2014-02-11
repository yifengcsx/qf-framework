package com.qf.framework.common.ds.list {
import com.qf.framework.common.ds.AbstractCollection;
import com.qf.framework.common.ds.Collection;
import com.qf.framework.common.ds.List;
import com.qf.framework.common.ds.Iterator;
import com.qf.framework.common.ds.error.UnsupportedOperationError;

/**
 *此类提供 List 接口的部分实现，从而最大限度地减少了实现支持的接口所需的工作。并提供 addAll(c:ICollection) 和 size(),removeAll(c:ICollection):Boolean,retainAll(c:ICollection):Boolean,
 *containsAll(c:ICollection):Boolean,isEmpty():Boolean ,toArray():Array 等方法的实现。
 * @see UnsupportedOperationError
 * @author 青竹
 * @email hui161@gmail.com
 */
public class AbstractList extends AbstractCollection implements List {

	public function AbstractList() {
	}

	/**
	 * @inheritDoc
	 */
	public function addAt(index:uint, o:*):Boolean {
		var i:ListIterator = listIteratorAt(index);
		i.add(o);
		return i != null;
	}

	/**
	 * @inheritDoc
	 */
	public function addAllAt(index:uint, o:Collection):void {
		throw new UnsupportedOperationError();
	}

	/**
	 * @inheritDoc
	 */
	public function get(index:uint):Object {

		return iteratorAt(index).next()
	}

	/**
	 * @inheritDoc
	 */
	public function indexOf(o:Object):int {
		throw new UnsupportedOperationError();
	}

	override public function contains(o:Object):Boolean {
		return indexOf(o) != -1;
	}

	/**
	 * @inheritDoc
	 */
	public function lastIndexOf(o:Object):int {
		throw new UnsupportedOperationError();
	}

	/**
	 * @inheritDoc
	 */
	public function subList(fromIndex:uint, toIndex:uint):List {
		throw new UnsupportedOperationError();
	}

	/**
	 * @inheritDoc
	 */
	public function removeAt(index:uint):Object {
		throw new UnsupportedOperationError();
	}

	/**
	 * @inheritDoc
	 */
	public function replace(index:uint, o:Object):Object {
		var i:ListIterator = listIteratorAt(index);
		var d:* = i.next();
		i.previous();
		i.replace(o);
		return d;
	}

	/**
	 * @inheritDoc
	 */
	public function iteratorAt(index:uint):Iterator {
		throw new UnsupportedOperationError();
	}

	/**
	 * @inheritDoc
	 */
	public function listIterator():ListIterator {
		return iterator() as ListIterator;
	}

	/**
	 * @inheritDoc
	 */
	public function listIteratorAt(index:int):ListIterator {
		return iteratorAt(index) as ListIterator;
	}
}
}