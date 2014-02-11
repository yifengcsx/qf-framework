package com.qf.framework.common.ds.tree {
/**
 * BinarySearchTree 结点.
 * @author 青竹
 * @email hui161@gmail.com
 */
internal class BinaryTreeNode {
	public var data:*;
	public var left:BinaryTreeNode;
	public var right:BinaryTreeNode;
	public var parent:BinaryTreeNode;

	public var x:Number = 0;
	public var y:Number = 0;

	public function BinaryTreeNode(data:*) {
		this.data = data;
	}
}
}