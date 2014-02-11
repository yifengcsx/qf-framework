package com.qf.framework.core.ioc.binding {
import com.qf.framework.common.reflect.Type;
import com.qf.framework.common.util.checkNotNull;
import com.qf.framework.core.ioc.Injector;
import com.qf.framework.core.ioc.injection.Injections;

/**
 * 类型提供器
 *
 * @author 毅峰
 */
public class TypeProvider implements Provider {

	public function TypeProvider(injector:Injector, type:Type, singleton:Boolean = false) {
		checkNotNull(injector);
		checkNotNull(type);
		this.injector = injector;
		this.type = type;
		this.singleton = singleton;
	}

	private var injector:Injector;
	private var type:Type;
	private var singleton:Boolean = false;
	private var instance:Object;

	public function get():* {
		if (singleton && instance) {
			return instance;
		}
		var target:Object = Injections.inject(injector, type);
		if (singleton) {
			instance = target;
		}
		return target;
	}

	internal function asSingleton():void {
		singleton = true;
	}

}
}
