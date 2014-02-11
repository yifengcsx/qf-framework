package com.qf.framework.ioc.injection {
import com.qf.framework.common.ds.Map;
import com.qf.framework.common.error.ErrorCenter;
import com.qf.framework.common.reflect.MethodParam;
import com.qf.framework.common.reflect.Type;
import com.qf.framework.ioc.Injector;
import com.qf.framework.ioc.error.BindingUndefinedError;

/**
 * 构造注入点
 *
 * @author 毅峰
 */
public class ConstructorInjectionPoint implements InjectionPoint {

	public function ConstructorInjectionPoint(type:Type, paramNameMap:Map = null) {
		this.type = type;
		this.paramNameMap = paramNameMap;
	}

	private var type:Type;
	private var paramNameMap:Map;

	public function inject(target:Object, injector:Injector):Object {
		if (target) {
			return target;
		}
		var params:Vector.<MethodParam> = type.getConstructorParams();
		var paramValues:Array = null;
		if (params.length != 0) {
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
		return type.newInstance(paramValues);
	}
}
}
