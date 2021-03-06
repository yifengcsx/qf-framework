package com.qf.framework.ioc.binding {
import com.qf.framework.common.reflect.Type;
import com.qf.framework.ioc.Key;

/**
 * 绑定器
 *
 * @author 毅峰
 */
public interface Binder {

	function bindClass(clazz:Class):NamedBindingBuilder;

	function bindType(type:Type):NamedBindingBuilder;

	function bindKey(key:Key):LinkedBindingBuilder;

	function createBinding():Binding;

}
}
