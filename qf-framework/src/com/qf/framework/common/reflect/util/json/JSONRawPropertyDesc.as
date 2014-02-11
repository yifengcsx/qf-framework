package com.qf.framework.common.reflect.util.json {
import com.qf.framework.common.reflect.util.RawMetadataDesc;
import com.qf.framework.common.reflect.util.RawPropertyDesc;

/**
 * 原始属性描述
 *
 * @author 毅峰
 */
internal class JSONRawPropertyDesc implements RawPropertyDesc {

	/** 名称 */
	private var name:String;
	/** 资源定位符 */
	private var uri:String;
	//noinspection ReservedWordAsName
	/** 类型 */
	private var type:String;
	/** 访问类型(AccessType常量) */
	private var access:String;
	/** 元数据 */
	private var metadatas:Vector.<RawMetadataDesc>;

	private var jsonMetadatas:Object;

	public function JSONRawPropertyDesc(obj:Object) {
		this.name = obj.name;
		this.uri = obj.uri;
		this.type = obj.type;
		this.access = obj.access;
		this.jsonMetadatas = obj.metadata;
	}

	public function getName():String {
		return name;
	}

	public function getUri():String {
		return uri;
	}

	public function getType():String {
		return type;
	}

	public function getAccess():String {
		return access;
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
}

}
