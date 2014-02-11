package com.qf.framework.common.reflect.util.json {
import com.qf.framework.common.reflect.util.RawMetadataDesc;
import com.qf.framework.common.reflect.util.RawMethodDesc;
import com.qf.framework.common.reflect.util.RawParamDesc;

/**
 * 原始方法描述
 *
 * @author 毅峰
 */
internal class JSONRawMethodDesc implements RawMethodDesc {

	/** 名称 */
	private var name:String;
	/** 资源表示符 */
	private var uri:String;
	/** 定义者 */
	private var declaredBy:String;
	/** 返回类型 */
	private var returnType:String;
	/** 元数据 */
	private var metadatas:Vector.<RawMetadataDesc>;
	/** 参数 */
	private var parameters:Vector.<RawParamDesc>;

	private var jsonMetadatas:Object;
	private var jsonParameters:Object;

	public function JSONRawMethodDesc(obj:Object) {
		this.name = obj.name;
		this.uri = obj.uri;
		this.declaredBy = obj.declaredBy;
		this.returnType = obj.returnType;
		this.jsonMetadatas = obj.metadata;
		this.jsonParameters = obj.parameters;
	}


	public function getName():String {
		return name;
	}

	public function getUri():String {
		return uri;
	}

	public function getDeclaredBy():String {
		return declaredBy;
	}

	public function getReturnType():String {
		return returnType;
	}

	public function getMetadatas():Vector.<RawMetadataDesc> {
		if (!metadatas) {
			metadatas = new <RawMetadataDesc>[];
			for each (var jsonMetadata:Object in jsonMetadatas) {
				metadatas.push(new JSONRawMetadataDesc(jsonMetadata));
			}
			jsonMetadatas = null;
		}
		return metadatas;
	}

	public function getParameters():Vector.<RawParamDesc> {
		if (!parameters) {
			parameters = new <RawParamDesc>[];
			for each (var jsonParam:Object in jsonParameters) {
				parameters.push(new JSONRawParamDesc(jsonParam));
			}
			jsonParameters = null;
		}
		return parameters;
	}
}

}
