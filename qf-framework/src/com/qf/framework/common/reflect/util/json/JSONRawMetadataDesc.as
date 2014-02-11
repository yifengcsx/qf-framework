package com.qf.framework.common.reflect.util.json {
import com.qf.framework.common.reflect.util.*;

/**
 * 原始元数据描述
 *
 * @author 毅峰
 */
internal class JSONRawMetadataDesc implements RawMetadataDesc {

	/** 名称 */
	private var name:String;
	/** 元数据值 */
	private var params:Vector.<RawMetadataParamDesc>;

	private var jsonParams:Object;

	public function JSONRawMetadataDesc(obj:Object) {
		this.name = obj.name;
		this.jsonParams = obj.value;
	}

	public function getName():String {
		return name;
	}

	public function getParams():Vector.<RawMetadataParamDesc> {
		if (!params) {
			params = new <RawMetadataParamDesc>[];
			for each (var jsonParam:Object in jsonParams) {
				params.push(new JSONRawMetadataParamDesc(jsonParam))
			}
			jsonParams = null;
		}
		return params;
	}
}

}
