package com.qf.framework.common.reflect {

/**
 * 成员
 *
 * @author 毅峰
 */
public interface Member {

	/**
	 * 获得成员名称
	 */
	function getName():String;

	/**
	 * 获得成员所有者
	 */
	function getOwner():Type;

	/**
	 * 是否为静态
	 */
	function isStatic():Boolean;

}
}
