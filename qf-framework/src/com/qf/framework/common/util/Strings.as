package com.qf.framework.common.util {

/**
 * 字符串工具
 *
 * @author 毅峰
 */
public final class Strings {

	private static const EMPTY_STRING:String = "";

	/**
	 * 字符串转Boolean
	 * @param str
	 * @return 如果字符串为"true"(不区分大小写)则返回true
	 */
	public static function string2Boolean(str:String):Boolean {
		return str.toLowerCase() == "true";
	}

	/**
	 * 去掉首尾空白字符
	 *
	 * @param str
	 * @return
	 */
	public static function trim(str:String):String {
		checkNotNull(str);
		return str.replace(/^\s+|\s+$/g, EMPTY_STRING);
	}

	/**
	 * 去掉左边空白字符
	 *
	 * @param str
	 * @return
	 */
	public static function trimLeft(str:String):String {
		checkNotNull(str);
		return str.replace(/^\s*/, "");
	}

	/**
	 * 去掉右边空白字符
	 *
	 * @param str
	 * @return
	 */
	public static function trimRight(str:String):String {
		checkNotNull(str);
		return str.replace(/\s*$/, "");
	}

}
}
