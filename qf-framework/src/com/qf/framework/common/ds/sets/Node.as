package com.qf.framework.common.ds.sets {
/**
 *
 * @author 青竹
 * @email hui161@gmail.com
 */
internal class Node {
	public var next:Node;
	public var prev:Node;
	public var data:*;

	function Node(data:*):void {
		this.data = data
	}

}
}