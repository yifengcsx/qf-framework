package com.qf.framework.common.ds.sets {
import com.qf.framework.common.ds.AbstractCollection;
import com.qf.framework.common.ds.Set;
import com.qf.framework.common.ds.Iterator;
import com.qf.framework.common.ds.ds_namespace;

import flash.utils.Dictionary;

/**
 * 基于Dictionary的 ISet 接口的实现,读写相对比LinkedSet和ArrayHashSet,(hashSet此为习惯性叫法,并没有采用哈希算法)。
 * @see Dictionary
 * @author 青竹
 * @email hui161@gmail.com
 */

public class HashSet extends AbstractCollection implements Set {
	use namespace ds_namespace;

	ds_namespace var _data:Dictionary;

	public function HashSet() {
		_data = new Dictionary(true)
	}

	/**
	 * @inheritDoc
	 */
	override public function add(o:*):Boolean {
		if (!_data.hasOwnProperty(o)) {
			_data[o] = o;
			_size++;
			return true;
		}
		return false;
	}

	/**
	 * @inheritDoc
	 */
	override public function remove(o:Object):Object {
		if (o in _data) {
			delete _data[o];
			_size--;
			return o;
		}
		return null;
	}

	/**
	 * @inheritDoc
	 */
	override public function iterator():Iterator {
		return new HashSetIterator(this);
	}

	/**
	 * @inheritDoc
	 */
	override public function contains(o:Object):Boolean {
		return o in _data;
	}

	/**
	 * @inheritDoc
	 */
	override public function clear():void {
		_data = new Dictionary(true);
		_size = 0
	}

	/**
	 * @inheritDoc
	 */
	override public function toArray():Array {
		var a:Array = [];
		for each(var i:* in _data) {
			a.push(i)
		}
		return a;
	}

}
}