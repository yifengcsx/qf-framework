package com.qf.framework.core.ioc.binding {
import com.qf.framework.common.reflect.Type;
import com.qf.framework.common.util.checkNotNull;
import com.qf.framework.common.util.isNull;
import com.qf.framework.core.ioc.Injector;
import com.qf.framework.core.ioc.Key;

/**
 *
 *
 * @author 毅峰
 */
internal class BinderImpl implements Binder, NamedBindingBuilder {

	public function BinderImpl(injector:Injector) {
		this.injector = injector;
	}

	private var injector:Injector;
	private var sourceType:Type;
	private var keyCreater:KeyCreater;
	private var bindingCreater:BindingCreater;

	public function bindClass(clazz:Class):NamedBindingBuilder {
		return bindType(Type.forClass(clazz));
	}

	public function bindType(type:Type):NamedBindingBuilder {
		sourceType = type;
		keyCreater = new KeyCreater();
		keyCreater.setType(type);
		return this;
	}

	public function bindKey(key:Key):LinkedBindingBuilder {
		keyCreater = new KeyCreater();
		keyCreater.setKey(key);
		return this;
	}

	public function createBinding():Binding {
		checkNotNull(keyCreater, "不够数据创建绑定!");
		if (!bindingCreater) {
			checkNotNull(sourceType, "不够数据创建绑定!");
			var creater:ProviderBindingCreater = new ProviderBindingCreater();
			creater.setInjector(injector);
			creater.setKeyCreater(keyCreater);
			creater.setType(sourceType);
			bindingCreater = creater;
		}
		return bindingCreater.create();
	}

	// ========================================

	public function widthNamed(name:String):LinkedBindingBuilder {
		keyCreater.setName(name);
		return this;
	}

	// =========================================

	public function toClass(clazz:Class):BindingBuilder {
		return toType(Type.forClass(clazz));
	}

	public function toType(type:Type):BindingBuilder {
		var creater:ProviderBindingCreater = new ProviderBindingCreater();
		creater.setInjector(injector);
		creater.setKeyCreater(keyCreater);
		creater.setType(type);
		bindingCreater = creater;
		return this;
	}

	public function toProvider(provider:Provider):void {
		var creater:ProviderBindingCreater = new ProviderBindingCreater();
		creater.setInjector(injector);
		creater.setKeyCreater(keyCreater);
		creater.setProvider(provider);
		bindingCreater = creater;
	}

	public function toProviderClass(providerClass:Class):void {
		toProviderType(Type.forClass(providerClass));
	}

	public function toProviderType(providerType:Type):void {
		toProvider(providerType.newInstance());
	}

	public function toInstance(ins:Object):void {
		var creater:InstanceBindingCreater = new InstanceBindingCreater();
		creater.setInstance(ins);
		creater.setKeyCreater(keyCreater);
		bindingCreater = creater;
	}

	// =================================

	public function asSingleton():void {
		if (isNull(bindingCreater)) {
			toType(sourceType);
		}
		if (bindingCreater is ProviderBindingCreater) {
			ProviderBindingCreater(bindingCreater).setSingleton(true);
		}
	}

}
}

import com.qf.framework.common.reflect.Type;
import com.qf.framework.common.util.checkNotNull;
import com.qf.framework.common.util.isNotNull;
import com.qf.framework.core.ioc.Injector;
import com.qf.framework.core.ioc.Key;
import com.qf.framework.core.ioc.binding.Binding;
import com.qf.framework.core.ioc.binding.InstanceBinding;
import com.qf.framework.core.ioc.binding.Provider;
import com.qf.framework.core.ioc.binding.ProviderBinding;
import com.qf.framework.core.ioc.binding.TypeProvider;

/**
 *
 */
class KeyCreater {

	public function KeyCreater() {
	}

	private var type:Type;
	private var name:String;
	private var key:Key;

	public function setType(type:Type):void {
		this.type = type;
	}

	public function setName(name:String):void {
		this.name = name;
	}

	public function setKey(key:Key):void {
		this.key = key;
	}

	public function create():Key {
		if (isNotNull(key)) {
			return key;
		}
		return Key.forType(type, name);
	}

}

/**
 *
 */
interface BindingCreater {

	function setKeyCreater(keyCreater:KeyCreater):void;

	function create():Binding;

}

/**
 *
 */
class ProviderBindingCreater implements BindingCreater {

	public function ProviderBindingCreater() {
	}

	private var keyCreater:KeyCreater;
	private var provider:Provider;
	private var type:Type;
	private var singleton:Boolean = false;
	private var injector:Injector;

	public function setKeyCreater(keyCreater:KeyCreater):void {
		this.keyCreater = keyCreater;
	}

	public function setProvider(provider:Provider):void {
		this.provider = provider;
	}

	public function setType(type:Type):void {
		this.type = type;
	}

	public function setSingleton(singleton:Boolean):void {
		this.singleton = singleton;
	}

	public function setInjector(injector:Injector):void {
		this.injector = injector;
	}

	public function create():Binding {
		if (!provider) {
			checkNotNull(injector, "请设置注入器!");
			checkNotNull(type, "缺少绑定类型!");
			provider = new TypeProvider(injector, type, singleton);
		}
		return new ProviderBinding(keyCreater.create(), provider);
	}
}

/**
 *
 */
class InstanceBindingCreater implements BindingCreater {

	public function InstanceBindingCreater() {
	}

	private var keyCreater:KeyCreater;
	private var ins:Object;

	public function setInstance(ins:Object):void {
		this.ins = ins;
	}

	public function setKeyCreater(keyCreater:KeyCreater):void {
		this.keyCreater = keyCreater;
	}

	public function create():Binding {
		return new InstanceBinding(keyCreater.create(), ins);
	}
}
