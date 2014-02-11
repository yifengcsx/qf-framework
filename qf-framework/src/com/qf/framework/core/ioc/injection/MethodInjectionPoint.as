package com.qf.framework.core.ioc.injection {
import com.qf.framework.common.ds.Map;
import com.qf.framework.common.error.ErrorCenter;
import com.qf.framework.common.reflect.Method;
import com.qf.framework.common.reflect.MethodParam;
import com.qf.framework.core.ioc.Injector;
import com.qf.framework.core.ioc.error.BindingUndefinedError;

/**
 * 方法注入点
 *
 * @author 毅峰
 */
public class MethodInjectionPoint implements InjectionPoint {

	public function MethodInjectionPoint(method:Method, paramNameMap:Map = null) {
		this.method = method;
		this.paramNameMap = paramNameMap;
	}

	private var method:Method;
	private var paramNameMap:Map;

	public function inject(target:Object, injector:Injector):Object {
		var params:Vector.<MethodParam> = method.getParams();
		var paramValues:Array = null;
		if (params.length > 0) {
			paramValues = [];
			for each (var methodParam:MethodParam in params) {
				var value:Object = injector.getInstanceByType(
						methodParam.getType(),
						Injections.getParamName(
								paramNameMap,
								methodParam
						)
				);
				if (value) {
					paramValues.push(value);
				} else {
					if (methodParam.isOptional()) {
						break;
					}
					ErrorCenter.get().throwError(new BindingUndefinedError());
					return null;
				}
			}
		}
		method.invoke(target, paramValues);
		return target;
	}

}
}
