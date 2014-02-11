package com.qf.framework.common.reflect.util.json {
import com.qf.framework.common.reflect.util.RawParamDesc;
import com.qf.framework.common.util.string2Boolean;

/**
 * 原始参数描述
 *
 * @author 毅峰
 */
internal class JSONRawParamDesc implements RawParamDesc {

	/** 参数类型 */
	private var type:String;
	/** 是否可选 */
	private var optional:Boolean;

	public function JSONRawParamDesc(obj:Object) {
		this.type = obj.type;
		this.optional = string2Boolean(obj.optional);
	}

	public function getType():String {
		return type;
	}

	public function getOptional():Boolean {
		return optional;
	}
}

}
