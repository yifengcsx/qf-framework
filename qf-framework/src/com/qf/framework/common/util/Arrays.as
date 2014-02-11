package com.qf.framework.common.util {

/**
 * 数组工具
 *
 * @author 毅峰
 */
public class Arrays {

	[Inline]
	/**
	 * 判定数组是否为空
	 *
	 * @param array 需要判定的数组
	 * @return
	 */
	public static function isEmpty(array:Array):Boolean {
		if (isNull(array)) {
			return true;
		}
		return array.length == 0;
	}

}
}
