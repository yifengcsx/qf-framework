package com.qf.framework.ioc.binding {
import com.qf.framework.common.error.ErrorCenter;
import com.qf.framework.common.reflect.Type;
import com.qf.framework.ioc.Injector;
import com.qf.framework.ioc.Key;

/**
 *
 *
 * @author 毅峰
 */
public class AbstractConfig implements Config {

	public function AbstractConfig() {
	}

	private var injector:Injector;
	private var binderList:Vector.<Binder> = new <Binder>[];

	public final function configure(injector:Injector):void {
		this.injector = injector;
		try {
			subConfig(injector);
			for each (var binder:Binder in binderList) {
				injector.addBinding(binder.createBinding());
			}
		} catch (error:Error) {
			ErrorCenter.get().throwError(error);
		}
	}

	protected final function bindClass(clazz:Class):NamedBindingBuilder {
		var binder:Binder = new BinderImpl(injector);
		binderList.push(binder);
		return binder.bindClass(clazz);
	}

	protected final function bindType(type:Type):NamedBindingBuilder {
		var binder:Binder = new BinderImpl(injector);
		binderList.push(binder);
		return binder.bindType(type);
	}

	protected final function bindKey(key:Key):LinkedBindingBuilder {
		var binder:Binder = new BinderImpl(injector);
		binderList.push(binder);
		return binder.bindKey(key);
	}

	protected function subConfig(injector:Injector):void {
	}

}
}
