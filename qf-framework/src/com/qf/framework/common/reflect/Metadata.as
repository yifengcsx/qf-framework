package com.qf.framework.common.reflect {
import com.qf.framework.common.base.Equality;
import com.qf.framework.common.reflect.util.RawMetadataDesc;
import com.qf.framework.common.reflect.util.RawMetadataParamDesc;
import com.qf.framework.common.util.isEqual;

/**
 * 元数据
 *
 * @author 毅峰
 */
public class Metadata implements Equality {

	private var name:String;
	private var params:Vector.<MetadataParam>;

	private var rawDesc:RawMetadataDesc;

	public function Metadata(rawDesc:RawMetadataDesc) {
		this.name = rawDesc.getName();
		this.rawDesc = rawDesc;
	}

	public function getName():String {
		return name;
	}

	public function getParam(name:String):MetadataParam {
		for each (var arg:MetadataParam in getParams()) {
			if (arg.getName() == name) {
				return arg;
			}
		}
		return null;
	}

	public function hasParam(name:String):Boolean {
		return getParam(name) != null;
	}

	public function getParams():Vector.<MetadataParam> {
		if (!params) {
			params = new <MetadataParam>[];
			for each (var rawValueDesc:RawMetadataParamDesc in rawDesc.getParams()) {
				params.push(new MetadataParam(rawValueDesc));
			}
		}
		return params;
	}

	public function toString():String {
		return "Metadata{name=" + getName() + ",args=[" + getParams().join() + "]}";
	}

	public function equal(obj:*):Boolean {
		if (obj is Metadata) {
			var m:Metadata = obj;
			if (this.name == m.name) {
				var thisPS:Vector.<MetadataParam> = this.getParams();
				var mPS:Vector.<MetadataParam> = m.getParams();
				if (thisPS.length == mPS.length) {
					var l:uint = thisPS.length;
					for (var i:int = 0; i < l; i++) {
						if (!isEqual(thisPS[i], mPS[i])) {
							return false;
						}
					}
					return true;
				}
			}
		}
		return false;
	}
}

}
