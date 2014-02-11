package com.qf.framework.ioc.injection {
import com.qf.framework.common.error.ErrorCenter;
import com.qf.framework.common.reflect.Field;
import com.qf.framework.ioc.Injector;
import com.qf.framework.ioc.Key;
import com.qf.framework.ioc.error.BindingUndefinedError;

/**
 * 字段注入点
 *
 * @author 毅峰
 */
public class FieldInjectionPoint implements InjectionPoint {

	public function FieldInjectionPoint(field:Field, option:Boolean = false, name:String = null) {
		this.field = field;
		this.option = option;
		this.key = Key.forType(field.getType(), name);
	}

	private var field:Field;
	private var key:Key;
	private var option:Boolean;

	public function inject(target:Object, injector:Injector):Object {
		if (!injector.hasBinding(key) && !option) {
			ErrorCenter.get().throwError(new BindingUndefinedError());
		}
		var obj:Object = injector.getInstanceByKey(key);
		field.setValue(target, obj);
		return target;
	}

}
}
