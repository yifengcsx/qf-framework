package com.qf.framework.common.util {
import com.qf.framework.common.base.Equality;

[Inline]
/**
 * 判断两个对象是否相等
 *
 * @param obj1 对象1
 * @param obj2 对象2
 * @return
 */
public function isEqual(obj1:Object, obj2:Object):Boolean {
	if (obj1 == obj2) {
		return true;
	} else if (obj1 is Equality) {
		return Equality(obj1).equal(obj2);
	}
	return false;
}

}
