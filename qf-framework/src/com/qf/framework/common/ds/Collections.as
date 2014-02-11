package com.qf.framework.common.ds {
import com.qf.framework.common.ds.list.LinkedList;
import com.qf.framework.common.ds.list.LinkedListIterator;

/**
 * 各种对集合和数组操作的方法。
 * 其中包括各种排序算法。
 * @author 青竹
 * @email hui161@gmail.com
 */
public class Collections {
	public function Collections() {
	}

	/**
	 * 将所有元素从一个列表复制到另一个列表。
	 * @param c
	 * @param l
	 *
	 */
	public static function copy(c:List, l:List):void {
		var i:Iterator = c.iterator();
		var j:int = 0;
		while (i.hasNext()) {
			l.addAt(j++, i.next())
		}
	}

	/**
	 * 返回指定 collection 中等于指定对象的元素数。
	 * @return
	 *
	 */
	public static function frequency(c:Collection, o:*):int {
		var count:int = 0;
		var i:Iterator = c.iterator();
		while (i.hasNext()) {
			if (i.next() === o) {
				count++;
			}
		}
		return count;
	}

	/**
	 * 冒泡排序的实现。 </br>
	 * 冒泡排序算法速度非常慢，但是算法实现非常简单。
	 * <li>算法将对原始数组做修改</li>
	 * @param array 须排序的数据。
	 * @param compareFun 比较函数，返回布尔值，接收2个参数据，如果参数为空则以默认比较(从小到大)。</br>如:compareFun=function(value1:*,value2:*):Boolean{return value1>value2;}。
	 *
	 */
	public static function bubbleSort(array:Array, compareFun:Function = null):void {
		if (compareFun == null) {
			compareFun = function (value1:*, value2:*):Boolean {return value1 > value2;}
		}
		var size:uint = array.length;
		var temp:* = array[0];
		for (var i:int = size - 1; i > 0; i--) {
			for (var j:int = 0; j < i; j++) {
				if (compareFun(array[j], array[j + 1])) {
					temp = array[j];
					array[j] = array[j + 1];
					array[j + 1] = temp;
				}
			}
		}
	}

	/**
	 * 择选排序实现。</br>
	 * 择选排序改进了冒泡排序.
	 * <li>算法将对原始数组做修改</li>
	 * @param array 须排序的数据。
	 * @param compareFun 比较函数，返回布尔值，接收2个参数据，如果参数为空则以默认比较(从小到大)。</br>如:compareFun=function(value1:*,value2:*):Boolean{return value1>value2;}。
	 */
	public static function selectSort(array:Array, compareFun:Function = null):void {
		if (compareFun == null) {
			compareFun = function (value1:*, value2:*):Boolean {return value1 > value2;}
		}
		var size:uint = array.length;
		var temp:* = array[0];
		for (var i:int = 0; i < size - 1; i++) {
			for (var j:int = i + 1; j < size; j++) {
				if (compareFun(array[i], array[j])) {
					temp = array[j];
					array[j] = array[i];
					array[i] = temp;
				}
			}
		}
	}

	/**
	 * 插入排序实现。</br>
	 * 与冒泡和择选相比，插入排序排序更加的优秀.一般比冒泡要快一倍，比选择排序也要快。
	 * <li>算法将对原始数组做修改</li>
	 * @param array 须排序的数据。
	 * @param compareFun 比较函数，返回布尔值，接收2个参数据，如果参数为空则以默认比较(从小到大)。</br>如:compareFun=function(value1:*,value2:*):Boolean{return value1>value2;}。
	 */
	public static function insertSort(array:Array, compareFun:Function = null):void {
		if (compareFun == null) {
			compareFun = function (value1:*, value2:*):Boolean {return value1 > value2;}
		}
		var size:uint = array.length;
		var temp:*;

		for (var i:int = 1; i < size; i++) {
			temp = array[i];
			for (var j:int = i - 1; j >= 0; j--) {
				if (compareFun(temp, array[j])) {
					array[j + 1] = array[j];
					break;
				}
				array[j + 1] = array[j]
			}
			array[j + 1] = temp;
		}

	}

	/**
	 * 堆排序实现。</br>
	 *  <li>算法将对原始数组做修改</li>
	 * @param array 须排序的数据。
	 * @param compareFun 比较函数，返回布尔值，接收2个参数据，如果参数为空则以默认比较(从小到大)。</br>如:compareFun=function(value1:*,value2:*):Boolean{return value1>value2;}。
	 * @see Heap
	 */
	public static function heapSort(array:Array, compareFun:Function = null):void {
		var heap:Heap = new Heap();
		var size:int = array.length;
		if (compareFun != null) {
			heap.setCompareFunction(compareFun)
		}
		for (var i:int = 0; i < size; i++) {
			heap.add(array[i]);
		}
		for (i = 0; i < size; i++) {
			array[i] = heap.removeTop();
		}
	}

	/**
	 * 快速排序实现。</br>
	 * 快速排序是以上所有排序中最快的,所以也是最流行的。
	 *  <li>算法将对原始数组做修改</li>
	 * @param array 须排序的数据。
	 * @param compareFun 比较函数，返回布尔值，接收2个参数据，如果参数为空则以默认比较(从小到大)。</br>如:compareFun=function(value1:*,value2:*):Boolean{return value1>value2;}。
	 * @see Heap
	 */
	public static function quickSort(array:Array, compareFun:Function = null):void {
		if (compareFun == null) {
			compareFun = function (value1:*, value2:*):Boolean {return value1 > value2;}
		}
		var size:uint = array.length;
		sort(0, size - 1);
		function sort(left:int, right:int):void {
			if (left >= right) {
				return;
			}
			var mid:* = getPartition(left, right, array[right]);
			sort(left, mid - 1);
			sort(mid + 1, right);
		}

		function getPartition(left:int, right:int, mid:*):* {
			var lp:int = left - 1;
			var rp:int = right;
//			var len:int = array.length;
			var temp:*;
			while (true) {
				while (compareFun(mid, array[++lp])) {}
				while (rp > 0 && compareFun(array[--rp], mid)) {}
				if (lp >= rp) {
					break;
				} else {
					temp = array[lp];
					array[lp] = array[rp];
					array[rp] = temp;
				}
			}
			temp = array[right];
			array[right] = array[lp];
			array[lp] = temp;
			return lp;
		}

	}

	/**
	 * 基于链表的插入排序实现。</br>
	 * 由于对速度的提升，此算法才用LinkedList来实现,如果最终数据需要数组，可以采用LinkedList.toArray()方法获取。</br>
	 * 理论基于链表的实现会更快(因为链表插入速度快)，但实际并非如此。原因是排序过程中需要不断创建节点，创建节点实例的过程非常耗时.
	 * @param array 须排序的数据。
	 * @param compareFun 比较函数，返回布尔值，接收2个参数据，如果参数为空则以默认比较(从小到大)。</br>如:compareFun=function(value1:*,value2:*):Boolean{return value1>value2;}。
	 * @see LinkedList
	 */
	public static function insertLinkedSort(array:Array, compareFun:Function = null):LinkedList {
		if (compareFun == null) {
			compareFun = function (value1:*, value2:*):Boolean {return value1 > value2;}
		}
		var size:uint = array.length;
		var temp:*;
		var list:LinkedList = new LinkedList(array[0]);
		var lock:Boolean;
		var it:LinkedListIterator = list.listIterator() as LinkedListIterator;
		for (var i:int = 1; i < size; i++) {
			it.reset();
			lock = true;
			while (it.hasNext()) {
				temp = it.peek();
				if (compareFun(temp, array[i])) {
					lock = false;
					list.insertBeforeByIterator(it, array[i]);
					break;
				}
				it.next();
			}
			if (lock) {
				list.addAtLast(array[i])
			}
		}
		return list;
	}

}
}