package com.qf.framework.core.ioc {
import com.qf.framework.common.reflect.Type;
import com.qf.framework.core.ioc.binding.Binding;
import com.qf.framework.core.ioc.binding.Config;

import flash.system.ApplicationDomain;

/**
 * 注入器
 *
 * @author 毅峰
 */
public interface Injector {

	/**
	 * 注入对象
	 *
	 * @param obj 需要注入的对象
	 */
	function injectObject(obj:Object):void;

	/**
	 * 获得绑定
	 *
	 * @param key
	 * @return
	 */
	function getBinding(key:Key):Binding;

	/**
	 * 通过类型获得实例
	 *
	 * @param type
	 * @param name
	 * @return
	 */
	function getInstanceByType(type:Type, name:String = null):*;

	/**
	 * 通过Class获得实例
	 *
	 * @param clazz
	 * @param name
	 * @return
	 */
	function getInstanceByClass(clazz:Class, name:String = null):*;

	/**
	 * 通过Key获得实例
	 * @param key
	 * @return
	 */
	function getInstanceByKey(key:Key):*;

	/**
	 * 添加绑定
	 *
	 * @param binding
	 * @return
	 */
	function addBinding(binding:Binding):Injector;

	/**
	 * 获得应用程序域
	 *
	 * @return
	 */
	function getAppDomain():ApplicationDomain;

	/**
	 * 添加配置
	 *
	 * @param config
	 * @return
	 */
	function appendConfig(config:Config):Injector;

	/**
	 * 添加多个配置
	 * @param configs
	 * @return
	 */
	function appendConfigs(configs:Array):Injector;

	/**
	 * 添加配置Class
	 *
	 * @param configClass
	 * @return
	 */
	function appendConfigClass(configClass:Class):Injector;

	/**
	 * 添加多个配置Class
	 *
	 * @param configClasses
	 * @return
	 */
	function appendConfigClasses(configClasses:Array):Injector;

	/**
	 * 是否有指定绑定
	 *
	 * @param key
	 * @return
	 */
	function hasBinding(key:Key):Boolean;

	/**
	 * 获得父注入器
	 *
	 * @return
	 */
	function getParent():Injector;

	/**
	 * 是否为根注入器
	 *
	 * @return
	 */
	function isRoot():Boolean;

}
}
