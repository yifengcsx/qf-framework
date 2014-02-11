package com.qf.framework.common.ds.list {
/**
 *
 * @author 青竹
 * @email hui161@gmail.com
 */
internal class LinkedNode {
	public var data:*;
	public var next:LinkedNode;
	public var prev:LinkedNode;

	public function LinkedNode(data:* = null) {
		this.data = data;
	}
}
}