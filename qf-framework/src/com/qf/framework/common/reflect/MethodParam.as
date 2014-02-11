package com.qf.framework.common.reflect {
import com.qf.framework.common.reflect.util.RawParamDesc;

/**
 * 方法参数
 *
 * @author 毅峰
 */
public class MethodParam {

	public function MethodParam(paramDesc:RawParamDesc, index:int) {
		this.paramDesc = paramDesc;
		this.optional = paramDesc.getOptional();
		this.index = index;
	}

	private var optional:Boolean;
	private var type_:Type;
	private var index:int;

	private var paramDesc:RawParamDesc;

	public function isOptional():Boolean {
		return optional;
	}

	public function getIndex():int {
		return index;
	}

	public function getType():Type {
		if (!type_) {
			type_ = Type.forClassName(paramDesc.getType());
		}
		return type_;
	}
}

}
