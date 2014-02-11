package com.qf.framework.common.reflect.util {

/**
 * 原始访问器(getter,setter)描述
 *
 * @author 毅峰
 */
public interface RawAccessorDesc extends RawPropertyDesc {

	/** 定义者 */
	function getDeclaredBy():String;

}

}
