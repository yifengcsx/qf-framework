package com.qf.framework.common.reflect {
import com.qf.framework.common.reflect.util.RawMethodDesc;
import com.qf.framework.common.reflect.util.RawParamDesc;

/**
 * 方法
 *
 * @author 毅峰
 */
public class Method extends AbstractMetadataOwner implements Member {

	public function Method(owner:Type, methodDesc:RawMethodDesc, static_:Boolean) {
		super(methodDesc.getMetadatas());
		this.owner = owner;
		this.name = methodDesc.getName();
		this.static_ = static_;
		this.methodDesc = methodDesc;
	}

	private var name:String;
	private var owner:Type;
	private var static_:Boolean;
	private var returnType:Type;
	private var params:Vector.<MethodParam>;

	private var methodDesc:RawMethodDesc;

	public function getName():String {
		return name;
	}

	public function getOwner():Type {
		return owner;
	}

	public function isStatic():Boolean {
		return static_;
	}

	public function getReturnType():Type {
		if (!returnType) {
			returnType = Type.forClassName(methodDesc.getReturnType());
		}
		return returnType;
	}

	public function getParams():Vector.<MethodParam> {
		if (!params) {
			params = new <MethodParam>[];
			var i:int = 0;
			for each (var paramDesc:RawParamDesc in methodDesc.getParameters()) {
				params.push(new MethodParam(paramDesc, i++));
			}
		}
		return params;
	}

	public function invoke(obj:Object, paramValues:Array = null):* {
		var fun:Function = obj[name];
		if (!paramValues || paramValues.length == 0) {
			return fun();
		}
		switch (paramValues.length) {
			case 1:
				return fun(paramValues[0]);
			case 2:
				return fun(paramValues[0], paramValues[1]);
			case 3:
				return fun(paramValues[0], paramValues[1], paramValues[2]);
			case 4:
				return fun(paramValues[0], paramValues[1], paramValues[2], paramValues[3]);
			case 5:
				return fun(paramValues[0], paramValues[1], paramValues[2], paramValues[3], paramValues[4]);
		}
		return fun.apply(null, paramValues);
	}

	public function toString():String {
		return "Method{name=" + getName()
				       + ",static=" + isStatic()
				       + ",returnType=" + getReturnType().getFullName()
				       + ",params=" + getParams().join()
				+ "}";
	}
}
}
