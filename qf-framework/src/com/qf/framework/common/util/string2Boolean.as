package com.qf.framework.common.util {

[Inline]
/**
 * 字符串转Boolean
 * @param s
 * @return 如果字符串为"true"(不区分大小写)则返回true
 */
public function string2Boolean(s:String):Boolean {
	return s.toLowerCase() == "true";
}

}
