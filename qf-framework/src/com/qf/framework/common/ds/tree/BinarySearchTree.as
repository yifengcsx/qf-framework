package com.qf.framework.common.ds.tree {
import com.qf.framework.common.ds.AbstractCollection;
import com.qf.framework.common.ds.Iterator;

/**
 * 二叉搜索树，二叉搜索树结构结合了数组和链表的优点。
 * 查找数据据项的速度和数组一样快，插入和删除的速度和链表一样快。
 * 但是如果二叉搜索树插入有序的数据或逆序的数据速度会变的非常慢。
 * <li>注意:大多数情下你可以使用inorder() postorder() preorder()方法进行遍历，而不是使用迭代器。</li>
 * @author 青竹
 * @email hui161@gmail.com
 */
public class BinarySearchTree extends AbstractCollection {
	private var root:BinaryTreeNode;
	private var compare:Function;

	public function BinarySearchTree(...arg) {
		compare = function (value1:Object, value2:Object):Boolean {
			return value1 > value2;
		};
		for (var i:int = 0; i < arg.length; i++) {
			add(arg[i]);
		}
	}

	/**
	 * 设置比较运算的逻辑
	 * @param fun 比较运算的逻辑函数，此函数返回true与false;
	 *
	 */
	public function setCompareFunction(fun:Function):void {
		compare = fun;
	}

	/**
	 * @inheritDoc
	 */
	override public function add(data:*):Boolean {
		var newNode:BinaryTreeNode = new BinaryTreeNode(data);
		var currentNode:BinaryTreeNode = root;
		var currentParent:BinaryTreeNode;
		if (root) {
			while (true) {
				currentParent = currentNode;
				if (compare(currentNode.data, data)) {
					currentNode = currentNode.left;
					if (!currentNode) {
						currentParent.left = newNode;
						break;
					}
				} else {
					currentNode = currentNode.right;
					if (!currentNode) {
						currentParent.right = newNode;
						break;
					}
				}
			}
			newNode.parent = currentParent;
			_size++;
			return true;
		} else {
			root = newNode;
		}
		_size++;
		return true;
	}

	/**
	 * @inheritDoc
	 */
	override public function remove(o:Object):Object {
		var node:BinaryTreeNode = this.root;
		var isRight:Boolean;
		while (node && node.data != o) {
			if (compare(node.data, o)) {
				node = node.left;
				isRight = false
			} else {
				node = node.right;
				isRight = true;
			}
		}

		if (!node) {
			return null;
		}
		_size--;
		var data:* = node.data;
		//情况一
		if (!node.left && !node.right) {
			if (node == root) {
				root = null;
				return data;
			}
			if (isRight) {
				node.parent.right = null;
			} else {
				node.parent.left = null;
			}
			return data;
		}

		//情况二
		if (node.left) {
			if (node == root) {
				root = node.right;
				return data;
			}
			if (isRight) {
				node.parent.right = node.left;

			} else {
				node.parent.left = node.left;
			}
			node.left.parent = node.parent;
			return data;
		}
		if (node.right) {
			if (node == root) {
				root = node.right;
				return data;
			}
			if (isRight) {
				node.parent.right = node.right;
			} else {
				node.parent.left = node.right;
			}
			node.right.parent = node.parent;
			return data;
		}
		////情况三
		var newNode:BinaryTreeNode = this.getMinNode(node);
		newNode.left = node.left;
		newNode.right = node.right;
		if (node == root) {
			root = newNode;
			return data;
		}
		newNode.parent.left = null;
		newNode.parent = node.parent;
		if (node == root) {
			root = newNode;
		}
		if (node.parent) {
			if (isRight) {
				node.right = newNode;
			} else {
				node.left = newNode;
			}
		}
		return data;
	}

	/**
	 * 获取此结点的子节点中最小的一个结点.
	 * @param node
	 * @return
	 * @see TreeNode
	 */
	private function getMinNode(node:BinaryTreeNode):BinaryTreeNode {
		if (!node) {
			return null;
		}
		while (true) {
			if (node.left) {
				node = node.left;
			} else {
				return node;
			}
		}
		//noinspection UnreachableCodeJS
		return null;
	}

	/**
	 * @inheritDoc
	 */
	override public function clear():void {
		_size = 0;
		root = null;
	}

	/**
	 * @inheritDoc
	 */
	override public function contains(o:Object):Boolean {
		return getNode(o) != null;
	}

	//noinspection JSUnusedLocalSymbols
	/**
	 * 递归获取结点，由于函数的调用代价效率相对较低。
	 * @param o
	 * @return
	 *
	 */
	private function getNode1(o:*):BinaryTreeNode {
		var re:BinaryTreeNode;
		get(root);
		function get(node:BinaryTreeNode):void {
			if (!node || node.data == o) {
				re = node;
				return;
			}
			if (compare(node.data, o)) {
				get(node.left);
			} else {
				get(node.right);
			}
		}

		return re;
	}

	/**
	 * 此迭代器的效率很低，在大多数情况下可以才用 preorder(),inorder(),postorder()方法遍历.
	 * 也可以使toArray()方法,获取一个数据组，再对数遍历.
	 * @see preorder
	 * @see inorder
	 * @see postorder
	 */
	override public function iterator():Iterator {
		return new TreeIterator(this);
	}

	private function getNode(o:*):BinaryTreeNode {
		var node:BinaryTreeNode = this.root;
		while (node && node.data !== o) {
			if (compare(node.data, o)) {
				node = node.left
			} else {
				node = node.right;
			}
		}

		return node;
	}

	/**
	 * @inheritDoc
	 */
	override public function toArray():Array {
		var arr:Array = [];
		get(root);
		function get(node:BinaryTreeNode):void {
			if (!node) {
				return;
			}
			arr.push(node.data);
			get(node.right);
			get(node.left);
		}

		return arr;
	}

	/**
	 *以很快的速度返回集合中最大的一个.
	 * @return 最大值
	 *
	 */
	public function getMax():* {
		var m:BinaryTreeNode = root;
		while (true) {
			if (m.left) {
				m = root.left;
			} else {
				return m.data;
			}
		}
	}

	/**
	 *以很快的速度返回集合中最小的一个.
	 * @return 最小值
	 *
	 */
	public function getMin():* {
		var m:BinaryTreeNode = root;
		while (true) {
			if (m.left) {
				m = root.right;
			} else {
				return m.data;
			}
		}
	}

	/**
	 * 以中序遍历的顺序对树中的每一项执行函数。
	 * @param node 开始遍历的始结点
	 * @param fun 用来接收值的一个函数.
	 *
	 */
	public function inorder(node:BinaryTreeNode, fun:Function):void {
		if (!node) {
			return;
		}
		inorder(node.left, fun);
		fun(node.data);
		inorder(node.right, fun);
	}

	/**
	 *以后序遍历的顺序对树中的每一项执行函数。
	 * @param node 开始遍历的始结点
	 *@param fun 用来接收值的一个函数.
	 *
	 */
	public function postorder(node:BinaryTreeNode, fun:Function):void {
		if (!node) {
			return;
		}
		postorder(node.left, fun);
		postorder(node.right, fun);
		fun(node.data);
	}

	/**
	 * 以先序遍历的顺序对树中的每一项执行函数。
	 * @param node 开始遍历的始结点
	 * @param fun 用来接收值的一个函数.
	 *
	 */
	public function preorder(node:BinaryTreeNode, fun:Function):void {
		if (!node) {
			return;
		}
		fun(node.data);
		postorder(node.left, fun);
		postorder(node.right, fun);
	}
}
}