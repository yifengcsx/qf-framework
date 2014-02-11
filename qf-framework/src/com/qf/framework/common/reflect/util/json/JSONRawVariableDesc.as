package com.qf.framework.common.reflect.util.json {
import com.qf.framework.common.reflect.util.RawVariableDesc;

/**
 * 原始变量描述
 *
 * @author 毅峰
 */
internal class JSONRawVariableDesc extends JSONRawPropertyDesc implements RawVariableDesc {

	public function JSONRawVariableDesc(obj:Object) {
		super(obj);
	}
}

}
