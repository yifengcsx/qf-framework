package com.qf.framework.common.reflect.util.json {
import com.qf.framework.common.reflect.util.RawAccessorDesc;
import com.qf.framework.common.reflect.util.RawMetadataDesc;
import com.qf.framework.common.reflect.util.RawMethodDesc;
import com.qf.framework.common.reflect.util.RawParamDesc;
import com.qf.framework.common.reflect.util.RawTypeDesc;
import com.qf.framework.common.reflect.util.RawVariableDesc;
import com.qf.framework.common.util.string2Boolean;

/**
 * 原始类型描述
 *
 * @author 毅峰
 */
internal class JSONRawTypeDesc implements RawTypeDesc {

	/** 对应的Class */
	public var clazz:Class;
	/** 类型名称 */
	public var name:String;

	/** (实例)是否为静态的 */
	public var _static:Boolean;
	/** (实例)是否为动态的 */
	public var _dynamic:Boolean;
	/** (实例)是否为最终的 */
	public var _final:Boolean;
	/** (实例)方法 */
	public var methods:Vector.<RawMethodDesc>;
	/** (实例)构造参数 */
	public var _constructor:Vector.<RawParamDesc>;
	/** (实例)变量 */
	public var variables:Vector.<RawVariableDesc>;
	/** (实例)访问器 */
	public var accessors:Vector.<RawAccessorDesc>;
	/** (实例)父类 */
	public var superClasses:Vector.<String>;
	/** (实例)接口 */
	public var interfaces:Vector.<String>;
	/** (实例)类型元数据 */
	public var metadatas:Vector.<RawMetadataDesc>;

	/** (类)静态变量 */
	public var staticVariables:Vector.<RawVariableDesc>;
	/** (类)静态访问器 */
	public var staticAccessors:Vector.<RawAccessorDesc>;
	/** (类)静态方法 */
	public var staticMethods:Vector.<RawMethodDesc>;

	private var jsonInsTraits:Object;
	private var jsonClassTraits:Object;

	public function JSONRawTypeDesc(clazz:Class, jsonInsObj:Object, jsonClassObj:Object) {

		this.clazz = clazz;
		this.name = jsonInsObj.name;

		this._dynamic = string2Boolean(jsonInsObj.isDynamic);
		this._final = string2Boolean(jsonInsObj.isFinal);
		this._static = string2Boolean(jsonInsObj.isStatic);

		this.jsonInsTraits = jsonInsObj.traits;
		this.jsonClassTraits = jsonClassObj.traits;

	}

	public function getClass():Class {
		return clazz;
	}

	/** @inheritDoc */
	public function getName():String {
		return name;
	}

	/** @inheritDoc */
	public function isStatic():Boolean {
		return _static;
	}

	/** @inheritDoc */
	public function isDynamic():Boolean {
		return _dynamic;
	}

	/** @inheritDoc */
	public function isFinal():Boolean {
		return _final;
	}

	/** @inheritDoc */
	public function getMethods():Vector.<RawMethodDesc> {
		if (!methods) {
			methods = new <RawMethodDesc>[];
			for each (var jsonMethod:Object in jsonInsTraits.methods) {
				methods.push(new JSONRawMethodDesc(jsonMethod));
			}
		}
		return methods;
	}

	/** @inheritDoc */
	public function getConstructor():Vector.<RawParamDesc> {
		if (!_constructor) {
			_constructor = new <RawParamDesc>[];
			for each (var jsonParam:Object in jsonInsTraits.constructor) {
				_constructor.push(new JSONRawParamDesc(jsonParam));
			}
		}
		return _constructor;
	}

	/** @inheritDoc */
	public function getVariables():Vector.<RawVariableDesc> {
		if (!variables) {
			variables = new <RawVariableDesc>[];
			for each (var jsonVar:Object in jsonInsTraits.variables) {
				variables.push(new JSONRawVariableDesc(jsonVar));
			}
		}
		return variables;
	}

	/** @inheritDoc */
	public function getAccessors():Vector.<RawAccessorDesc> {
		if (!accessors) {
			accessors = new <RawAccessorDesc>[];
			for each (var jsonAccessor:Object in jsonInsTraits.accessors) {
				accessors.push(new JSONRawAccessorDesc(jsonAccessor));
			}
		}
		return accessors;
	}

	/** @inheritDoc */
	public function getSuperClasses():Vector.<String> {
		if (!superClasses) {
			superClasses = new <String>[];
			for each (var superName:String in jsonInsTraits.bases) {
				superClasses.push(superName);
			}
		}
		return superClasses;
	}

	/** @inheritDoc */
	public function getInterfaces():Vector.<String> {
		if (!interfaces) {
			interfaces = new <String>[];
			for each (var interfaceName:String in jsonInsTraits.interfaces) {
				interfaces.push(interfaceName);
			}
		}
		return interfaces;
	}

	/** @inheritDoc */
	public function getMetadatas():Vector.<RawMetadataDesc> {
		if (!metadatas) {
			metadatas = new <RawMetadataDesc>[];
			for each (var jsonMetadata:Object in jsonInsTraits.metadata) {
				metadatas.push(new JSONRawMetadataDesc(jsonMetadata));
			}
		}
		return metadatas;
	}

	/** @inheritDoc */
	public function getStaticVariables():Vector.<RawVariableDesc> {
		if (!staticVariables) {
			staticVariables = new <RawVariableDesc>[];
			for each (var jsonVar:Object in jsonClassTraits.variables) {
				staticVariables.push(new JSONRawVariableDesc(jsonVar));
			}
		}
		return staticVariables;
	}

	/** @inheritDoc */
	public function getStaticAccessors():Vector.<RawAccessorDesc> {
		if (!staticAccessors) {
			staticAccessors = new <RawAccessorDesc>[];
			for each (var jsonStaticAccessor:Object in jsonClassTraits.accessors) {
				staticAccessors.push(new JSONRawAccessorDesc(jsonStaticAccessor));
			}
		}
		return staticAccessors;
	}

	/** @inheritDoc */
	public function getStaticMethods():Vector.<RawMethodDesc> {
		if (!staticMethods) {
			staticMethods = new <RawMethodDesc>[];
			for each (var jsonStaticMethod:Object in jsonClassTraits.methods) {
				staticMethods.push(new JSONRawMethodDesc(jsonStaticMethod));
			}
		}
		return staticMethods;
	}
}
}
