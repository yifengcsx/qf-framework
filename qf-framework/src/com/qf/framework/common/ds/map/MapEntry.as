package com.qf.framework.common.ds.map {
/**
 * 映射项（键-值对）。
 * @author 青竹
 * @email hui161@gmail.com
 */
public class MapEntry {
	public var key:*;
	public var value:*;

	public function MapEntry(key:*, value:*) {
		this.key = key;
		this.value = value;
	}

	public function toString():String {
		return "[key=" + key + " value:" + value + "]";
	}
}
}