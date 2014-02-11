package com.qf.framework.common.ds {
import com.qf.framework.common.ds.error.UnsupportedOperationError;

/**
 * 此类提供了 ICollection 接口的骨干实现，从而最大限度地减少了实现此接口所需的工作。
 * @see Collection
 * @author 青竹
 * @email hui161@gmail.com
 */
public class AbstractCollection implements Collection {
	protected var _size:uint = 0;

	/**
	 * @inheritDoc
	 */
	public function add(o:*):Boolean {
		throw new UnsupportedOperationError();
	}

	/**
	 * @inheritDoc
	 */
	public function addAll(c:Collection):void {
		var i:Iterator = c.iterator();
		i.reset();
		while (i.hasNext()) {
			add(i.next());
		}
	}

	/**
	 * @inheritDoc
	 */
	public function clear():void {
		throw new UnsupportedOperationError();
	}

	/**
	 * @inheritDoc
	 */
	public function contains(o:Object):Boolean {
		throw new UnsupportedOperationError();
	}

	/**
	 * @inheritDoc
	 */
	public function containsAll(c:Collection):Boolean {
		var i:Iterator = c.iterator();
		i.reset();
		while (i.hasNext()) {
			if (!contains(i.next())) {
				return false;
			}
		}
		return true;
	}

	/**
	 * @inheritDoc
	 */
	public function equals(o:Object):Boolean {
		var itr:Iterator;
		var it:Iterator = iterator();
		if (o is AbstractCollection) {
			if (_size != AbstractCollection(o).size()) {
				return false;
			}
			itr = AbstractCollection(o).iterator();
			while (itr.hasNext()) {
				if (itr.next() != it.next()) {
					return false;
				}
			}
			return true
		}
		return false;
	}

	/**
	 * @inheritDoc
	 */
	public function isEmpty():Boolean {
		return _size <= 0;
	}

	/**
	 * @inheritDoc
	 */
	public function iterator():Iterator {
		return new NullIterator;
	}

	/**
	 * @inheritDoc
	 */
	public function remove(o:Object):Object {
		throw new UnsupportedOperationError();
	}

	/**
	 * @inheritDoc
	 *
	 */
	public function removeAll(c:Collection):Boolean {
		var i:Iterator = c.iterator();

		var temp:*;
		while (i.hasNext()) {
			temp = i.next();
			while (remove(temp)) {}
		}
		return true;
	}

	/**
	 * @inheritDoc
	 */
	public function retainAll(c:Collection):Boolean {
		/*实现一
		 var i:Iterator=iterator();
		 i.reset();
		 var temp:*;
		 var index:int=0;
		 while(i.hasNext()){
		 temp=i.next();
		 if(!c.contains(temp))  {
		 remove(temp);
		 i.reset();
		 }
		 }
		 */
		var i:Iterator = iterator();
		i.reset();
		var temp:*;
		var arr:Array = [];
		while (i.hasNext()) {
			temp = i.next();
			if (c.contains(temp)) {
				arr.push(temp);
			}
		}
		clear();
		var si:int = arr.length;
		for (var j:int = 0; j < si; j++) {
			add(arr[j]);
		}
		return true;
	}

	/**
	 * @inheritDoc
	 */
	public function size():uint {
		return _size;
	}

	/**
	 * @inheritDoc
	 */
	public function toArray():Array {
		var a:Array = [];
		var i:Iterator = iterator();
		i.reset();
		while (i.hasNext()) {
			a.push(i.next());
		}
		return a;
	}

	/**
	 * @inheritDoc
	 */
	public function toString():String {
		return "[" + toArray() + "]";
	}
}
}