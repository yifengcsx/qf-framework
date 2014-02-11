package com.qf.framework.common.reflect {
import com.qf.framework.common.base.Equality;
import com.qf.framework.common.reflect.util.RawMetadataParamDesc;

/**
 * 元数据参数
 *
 * @author 毅峰
 */
public class MetadataParam implements Equality {

	private var name:String, value:String;

	public function MetadataParam(rawDesc:RawMetadataParamDesc) {
		this.name = rawDesc.getName();
		this.value = rawDesc.getValue();
	}

	/**
	 * 获得参数Key
	 */
	public function getName():String {
		return name;
	}

	/**
	 * 获得原始参数值(String)
	 */
	public function getRawValue():String {
		return value;
	}

	/**
	 * 获得int参数值
	 */
	public function getIntValue():int {
		return parseInt(value);
	}

	/**
	 * 获得浮点参数值
	 */
	public function getFloatValue():Number {
		return parseFloat(value);
	}

	/**
	 * 获得Boolean参数值
	 */
	public function getBooleanValue():Boolean {
		return value.toLowerCase() == "true";
	}

	/**
	 * 获得JSON对象
	 */
	public function getJSONValue():Object {
		var json:Object = null;
		try {
			json = JSON.parse(value);
		} catch (error:*) {
		}
		return json;
	}

	/**
	 * 获得字符串数组
	 *
	 * @param separator 指定分割符，默认为","
	 * @return
	 */
	public function getStrArrayValue(separator:String = ","):Array {
		return value.split(separator);
	}

	public function toString():String {
		return "MetadataParam{name=" + name + ",value=" + value + "}";
	}

	public function equal(obj:*):Boolean {
		if (obj is MetadataParam) {
			var m:MetadataParam = obj;
			return this.name == m.name && this.value == m.value;
		}
		return false;
	}
}
}
