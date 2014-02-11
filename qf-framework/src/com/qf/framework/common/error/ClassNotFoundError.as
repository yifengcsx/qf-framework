package com.qf.framework.common.error {

/**
 * 类没找到错误
 *
 * @author 毅峰
 */
public class ClassNotFoundError extends Error {

	public function ClassNotFoundError(className:String) {
		super("找不到[" + className + "]的类定义!");
	}
}
}
