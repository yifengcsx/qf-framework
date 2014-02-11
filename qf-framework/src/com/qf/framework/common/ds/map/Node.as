package com.qf.framework.common.ds.map {
/**
 *
 * @author 青竹
 * @email hui161@gmail.com
 */
internal class Node {
	public var next:Node;
	public var prev:Node;
	public var data:*;

	public function Node(data:*) {
		this.data = data
	}
}
}