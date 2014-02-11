package com.qf.framework.common.reflect.util.json {
import com.qf.framework.common.reflect.util.RawAccessorDesc;

/**
 * 原始访问器(getter,setter)描述
 *
 * @author 毅峰
 */
internal class JSONRawAccessorDesc extends JSONRawPropertyDesc implements RawAccessorDesc {

	/** 定义者 */
	private var declaredBy:String;

	public function JSONRawAccessorDesc(obj:Object) {
		super(obj);
		this.declaredBy = obj.declaredBy;
	}

	public function getDeclaredBy():String {
		return declaredBy;
	}


}

}
