package com.qf.framework.core.ioc {
import com.qf.framework.common.error.ErrorCenter;
import com.qf.framework.common.reflect.Type;
import com.qf.framework.common.reflect.util.ClassUtils;
import com.qf.framework.common.util.checkNotNull;
import com.qf.framework.core.ioc.binding.Binding;
import com.qf.framework.core.ioc.binding.Config;
import com.qf.framework.core.ioc.error.BindRepetitionError;
import com.qf.framework.core.ioc.injection.Injections;

import flash.system.ApplicationDomain;
import flash.utils.Dictionary;

/**
 * 注入器实现
 *
 * @author 毅峰
 */
internal class InjectorImpl implements Injector {

	public function InjectorImpl(parent:Injector = null) {
		this.parent = parent;
	}

	internal var appDomain:ApplicationDomain;

	private var parent:Injector;
	private var bindingMap:Dictionary = new Dictionary();

	public function injectObject(obj:Object):void {
		checkNotNull(obj);
		var type:Type = Type.forInstance(obj);
		Injections.inject(this, type, obj);
	}

	public function getBinding(key:Key):Binding {
		if (hasBindingLocale(key)) {
			return bindingMap[key];
		}
		if (!isRoot()) {
			return parent.getBinding(key);
		}
		return null;
	}

	public function getInstanceByType(type:Type, name:String = null):* {
		var key:Key = Key.forType(type, name);
		return getInstanceByKey(key);
	}

	public function getInstanceByClass(clazz:Class, name:String = null):* {
		return getInstanceByType(Type.forClass(clazz), name);
	}

	public function getInstanceByKey(key:Key):* {
		return getBinding(key).provide();
	}

	public function addBinding(binding:Binding):Injector {
		var key:Key = binding.getKey();
		if (key in bindingMap) {
			ErrorCenter.get().throwError(new BindRepetitionError());
		}
		bindingMap[key] = binding;
		return this;
	}

	public function getAppDomain():ApplicationDomain {
		return appDomain;
	}

	public function appendConfig(config:Config):Injector {
		checkNotNull(config);
		config.configure(this);
		return this;
	}

	public function appendConfigs(configs:Array):Injector {
		for each (var config:Config in configs) {
			appendConfig(config);
		}
		return this;
	}

	public function appendConfigClass(configClass:Class):Injector {
		var config:Config = Config(ClassUtils.newInstance(configClass));
		appendConfig(config);
		return this;
	}

	public function appendConfigClasses(configClasses:Array):Injector {
		for each (var configClass:Class in configClasses) {
			appendConfigClass(configClass);
		}
		return this;
	}

	public function hasBinding(key:Key):Boolean {
		if (hasBindingLocale(key)) {
			return true;
		}
		if (!isRoot()) {
			return getParent().hasBinding(key);
		}
		return false;
	}

	public function getParent():Injector {
		return parent;
	}

	public function isRoot():Boolean {
		return parent == null;
	}

	private function hasBindingLocale(key:Key):Boolean {
		return key in bindingMap;
	}

}
}
