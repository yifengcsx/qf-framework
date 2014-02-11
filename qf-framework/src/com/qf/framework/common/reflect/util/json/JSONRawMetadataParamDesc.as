package com.qf.framework.common.reflect.util.json {
import com.qf.framework.common.reflect.util.RawMetadataParamDesc;

/**
 * 原始元数据值描述
 *
 * @author 毅峰
 */
internal class JSONRawMetadataParamDesc implements RawMetadataParamDesc {

	/** key */
	private var name:String;
	/** value */
	private var value:String;

	public function JSONRawMetadataParamDesc(obj:Object) {
		this.name = obj.key;
		this.value = obj.value;
	}

	public function getName():String {
		return name;
	}

	public function getValue():String {
		return value;
	}
}

}
