package com.qf.framework.common.reflect.util {

/**
 * 原始属性描述
 *
 * @author 毅峰
 */
public interface RawPropertyDesc {

	/** 名称 */
	function getName():String;

	/** 资源定位符 */
	function getUri():String;

	/** 类型 */
	function getType():String;

	/** 访问类型(AccessType常量) */
	function getAccess():String;

	/** 元数据 */
	function getMetadatas():Vector.<RawMetadataDesc>;

}

}
