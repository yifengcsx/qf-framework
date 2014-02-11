package com.qf.framework.common.reflect.util.json {
import avmplus.JSONAvmplusDescription;

import com.qf.framework.common.reflect.util.RawTypeDesc;

import com.qf.framework.common.reflect.util.RawTypeDescProvider;


/**
 * JSON原始类型描述提供器
 *
 * @author 毅峰
 */
public class JSONRawTypeDescProvider implements RawTypeDescProvider {

	private static const JSON_DESCRIPTION:JSONAvmplusDescription = new JSONAvmplusDescription();

	public function JSONRawTypeDescProvider() {
	}

	/** @inheritDoc */
	public function provide(clazz:Class):RawTypeDesc {
		var jsonInstanceDesc:Object = JSON_DESCRIPTION.getInstanceDescriptionJSON(clazz);
		var jsonClassDesc:Object = JSON_DESCRIPTION.getClassDescriptionJSON(clazz);
		return new JSONRawTypeDesc(clazz, jsonInstanceDesc, jsonClassDesc);
	}


}

}
