package com.qf.framework.common.reflect.util {
/**
 * 原始方法描述
 *
 * @author 毅峰
 */
public interface RawMethodDesc {

	/** 名称 */
	function getName():String;

	/** 资源表示符 */
	function getUri():String;

	/** 定义者 */
	function getDeclaredBy():String;

	/** 返回类型 */
	function getReturnType():String;

	/** 元数据 */
	function getMetadatas():Vector.<RawMetadataDesc>;

	/** 参数 */
	function getParameters():Vector.<RawParamDesc>;


}

}
