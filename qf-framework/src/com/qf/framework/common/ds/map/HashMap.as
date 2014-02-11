package com.qf.framework.common.ds.map {

import com.qf.framework.common.ds.Collection;
import com.qf.framework.common.ds.Iterator;
import com.qf.framework.common.ds.Map;
import com.qf.framework.common.ds.Set;
import com.qf.framework.common.ds.list.ArrayList;
import com.qf.framework.common.ds.sets.LinkedHashSet;

import flash.utils.Dictionary;

/**
 * 基于Dictionary的 IMap 接口的实现,读写相对比LinkedMap快但是迭代不如LinkedHashMap快,(hashMap此为习惯性叫法,并没有采用哈希算法)。
 * 此实现提供所有可选的映射操作，并允许使用 null 值和 null 键。
 * 此类不保证映射的顺序，特别是它不保证该顺序恒久不变。 LinkedMap和ArrayHashMap为顺序结构。
 * @see  com.qf.framework.common.ds.map.LinkedHashMap LinkedMap
 * @see Dictionary
 * @author 青竹
 * @email hui161@gmail.com
 */
public class HashMap extends AbstractMap {
	public function HashMap() {
		_keys = new Dictionary();
	}

	/**
	 * @inheritDoc
	 */
	override public function containsValue(o:Object):Boolean {
		for each (var p:* in _keys) {
			if (p == o) {
				return true;
			}
		}
		return false;
	}

	/**
	 * @inheritDoc
	 */
	override public function equals(o:*):Boolean {
		return false;
	}

	/**
	 * @inheritDoc
	 */
	override public function get(key:Object):* {
		return _keys[key];
	}

	/**
	 * @inheritDoc
	 */
	override public function put(key:Object, value:Object):void {
		if (!(key in _keys)) {
			_size++;
		}
		_keys[key] = value;
	}

	/**
	 * @inheritDoc
	 */
	override public function putAll(map:Map):void {
		var i:Iterator = map.entrySet().iterator();
		var r:MapEntry;
		while (i.hasNext()) {
			r = MapEntry(i.next());
			put(r.key, r.value);
		}
	}

	/**
	 * @inheritDoc
	 */
	override public function entrySet():Set {
		var set:Set = new LinkedHashSet();
		for (var i:* in _keys) {
			set.add(new MapEntry(i, _keys[i]));
		}
		return set;
	}

	/**
	 * @inheritDoc
	 */
	override public function removeByKey(key:*):* {
		var d:* = _keys[key];
		if (_keys.hasOwnProperty(key)) {
			delete _keys[key];
			_size--;
		}
		return d;
	}

	/**
	 * @inheritDoc
	 */
	override public function getAllValue():Collection {
		var array:ArrayList = new ArrayList();
		for each (var p:* in _keys) {
			array.add(p);
		}
		return array;
	}

	/**
	 * 对Map中的值进行迭代，HashMap的迭代速度远不如LinkedHashMap.
	 * <li>注意:如果利用removeByKey方法删除项以后，一定要重设迭代器，即调用reset()方法.(如果需要迭代建议使用LinkedMashMap)</li>
	 * @return
	 *
	 */
	public function iterator():HashMapIterator {
		return new HashMapIterator(this);
	}

}
}