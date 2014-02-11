package com.qf.framework.common.reflect.util {
/**
 * 原始类型描述
 *
 * @author 毅峰
 */
public interface RawTypeDesc {

	/** 对应的Class */
	function getClass():Class;

	/** (实例)类型名称 */
	function getName():String;

	/** (实例)是否为静态的 */
	function isStatic():Boolean;

	/** (实例)是否为动态的 */
	function isDynamic():Boolean;

	/** (实例)是否为最终的 */
	function isFinal():Boolean;

	/** (实例)方法 */
	function getMethods():Vector.<RawMethodDesc>;

	/** (实例)构造参数 */
	function getConstructor():Vector.<RawParamDesc>;

	/** (实例)变量 */
	function getVariables():Vector.<RawVariableDesc>;

	/** (实例)访问器 */
	function getAccessors():Vector.<RawAccessorDesc>;

	/** (实例)父类 */
	function getSuperClasses():Vector.<String>;

	/** (实例)接口 */
	function getInterfaces():Vector.<String>;

	/** (实例)类型元数据 */
	function getMetadatas():Vector.<RawMetadataDesc>;

	/** (类)静态变量 */
	function getStaticVariables():Vector.<RawVariableDesc>;

	/** (类)静态访问器 */
	function getStaticAccessors():Vector.<RawAccessorDesc>;

	/** (类)静态方法 */
	function getStaticMethods():Vector.<RawMethodDesc>;

}
}
