package com.qf.framework.core.ioc.binding {

/**
 *
 *
 * @author 毅峰
 */
public interface NamedBindingBuilder extends LinkedBindingBuilder {

	/**
	 * 绑定名称
	 * @param name
	 * @return
	 */
	function widthNamed(name:String):LinkedBindingBuilder;

}
}
