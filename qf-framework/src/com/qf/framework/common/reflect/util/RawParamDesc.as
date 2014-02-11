package com.qf.framework.common.reflect.util {

/**
 * 原始参数描述
 *
 * @author 毅峰
 */
public interface RawParamDesc {

	/** 参数类型 */
	function getType():String;

	/** 是否可选 */
	function getOptional():Boolean;

}

}
