package com.qf.framework.ioc {
import com.qf.framework.common.reflect.Type;
import com.qf.framework.common.util.isNull;
import com.qf.framework.ioc.binding.Binding;
import com.qf.framework.ioc.binding.InstanceBinding;

import flash.system.ApplicationDomain;

/**
 * 注入器构建器
 *
 * @author 毅峰
 */
public class InjectorBuilder {

	public static function create():InjectorBuilder {
		return new InjectorBuilder();
	}

	public function InjectorBuilder() {
	}

	private var appDomain:ApplicationDomain;
	private var parent:Injector;

	public function setAppDomain(appDomain:ApplicationDomain):InjectorBuilder {
		this.appDomain = appDomain;
		return this;
	}

	public function setParent(parent:Injector):InjectorBuilder {
		this.parent = parent;
		return this;
	}

	public function build():Injector {
		var injector:InjectorImpl = new InjectorImpl(this.parent);
		if (isNull(this.appDomain)) {
			if (this.parent) {
				this.appDomain = this.parent.getAppDomain();
			} else {
				this.appDomain = ApplicationDomain.currentDomain;
			}
		}
		injector.appDomain = this.appDomain;
		var injectorBinding:Binding = new InstanceBinding(Key.forType(Type.forClass(Injector)), injector);
		injector.addBinding(injectorBinding);
		return injector;
	}

}
}
