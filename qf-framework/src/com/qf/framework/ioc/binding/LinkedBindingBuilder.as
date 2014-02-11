package com.qf.framework.ioc.binding {
import com.qf.framework.common.reflect.Type;

/**
 * 链接的绑定创建器
 *
 * @author 毅峰
 */
public interface LinkedBindingBuilder extends BindingBuilder {

	function toClass(clazz:Class):BindingBuilder;

	function toType(type:Type):BindingBuilder;

	function toProvider(provider:Provider):void;

	function toProviderClass(providerClass:Class):void;

	function toProviderType(providerType:Type):void;

	function toInstance(ins:Object):void;

}
}
