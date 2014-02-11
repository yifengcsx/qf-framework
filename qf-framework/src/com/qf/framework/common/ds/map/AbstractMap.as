package com.qf.framework.common.ds.map {
import com.qf.framework.common.ds.Collection;
import com.qf.framework.common.ds.Map;
import com.qf.framework.common.ds.Set;
import com.qf.framework.common.ds.sets.LinkedHashSet;

import flash.utils.Dictionary;

/**
 * Map的基类,其中实现了,clear(),containsKey,containsValue等方法。
 * @author 青竹
 * @email hui161@gmail.com
 */
public class AbstractMap implements Map {
	protected var _size:uint = 0;
	protected var _keys:Dictionary;

	public function AbstractMap() {
	}

	/**
	 * @inheritDoc
	 */
	public function clear():void {
		_keys = new Dictionary();
		_size = 0;
	}

	/**
	 * @inheritDoc
	 */
	public function containsKey(key:Object):Boolean {
		return _keys[key] != null;
	}

	/**
	 * @inheritDoc
	 */
	public function containsValue(value:Object):Boolean {
		for each (var p:* in _keys) {
			if (p.data === value) {
				return true
			}
		}
		return false;
	}

	/**
	 * @inheritDoc
	 */
	public function equals(o:*):Boolean {
		return false;
	}

	/**
	 * @inheritDoc
	 */
	public function entrySet():Set {
		return null;
	}

	/**
	 * @inheritDoc
	 */
	public function get(key:Object):* {
		return null;
	}

	/**
	 * @inheritDoc
	 */
	public function isEmpty():Boolean {
		return _size == 0;
	}

	/**
	 * @inheritDoc
	 */
	public function keySet():Set {
		var set:Set = new LinkedHashSet;
		for (var i:* in _keys) {
			set.add(i);
		}
		return set;
	}

	/**
	 * @inheritDoc
	 */
	public function put(key:Object, value:Object):void {
	}

	/**
	 * @inheritDoc
	 */
	public function putAll(map:Map):void {
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
	public function getAllValue():Collection {
		return null;
	}

	/**
	 * @inheritDoc
	 */
	public function removeByKey(key:*):* {
		return null;
	}
}
}