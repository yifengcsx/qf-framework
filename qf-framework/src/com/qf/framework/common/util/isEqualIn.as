package com.qf.framework.common.util {

[Inline]
/**
 * 判定指定对象是否与给定的对象之一相等
 *
 * @param from
 * @param target1
 * @param target2
 * @param target3
 * @param target4
 * @param target5
 * @return
 */
public function isEqualIn(from:Object, target1:Object, target2:Object = null, target3:Object = null, target4:Object = null, target5:Object = null):Boolean {
	checkNotNull(from);
	return isEqual(from, target1) ||
			isEqual(from, target2) ||
			isEqual(from, target3) ||
			isEqual(from, target4) ||
			isEqual(from, target5);
}

}
