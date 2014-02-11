package com.qf.framework.common.reflect.util {


/**
 * 原始元数据描述
 *
 * @author 毅峰
 */
public interface RawMetadataDesc {

	/** 名称 */
	function getName():String;

	/** 元数据值 */
	function getParams():Vector.<RawMetadataParamDesc>;

}

}
