package com.qf.framework.common.reflect.util {
import flash.utils.Dictionary;

/**
 * 原始类型描述缓存
 *
 * @author 毅峰
 */
internal class RawTypeDescCache {

	private static const INS:RawTypeDescCache = new RawTypeDescCache();

	public static function get():RawTypeDescCache {
		return INS;
	}

	private var descList:Vector.<RawTypeDesc> = new <RawTypeDesc>[];
	private var descIndexMap$name:Dictionary = new Dictionary();
	private var descIndexMap$class:Dictionary = new Dictionary();

	public function RawTypeDescCache() {
	}

	public function add(desc:RawTypeDesc):void {
		if (!hasByClass(desc.getClass())) {
			var newIndex:int = descList.length;
			descList[newIndex] = desc;
			descIndexMap$name[desc.getName()] = newIndex;
			descIndexMap$class[desc.getClass()] = newIndex;
		}
	}

	public function hasByClassName(className:String):Boolean {
		return className in descIndexMap$name;
	}

	public function hasByClass(clazz:Class):Boolean {
		return clazz in descIndexMap$class;
	}

	public function getByName(className:String):RawTypeDesc {
		var index:int = descIndexMap$name[className];
		return descList[index];
	}

	public function getByClass(clazz:Class):RawTypeDesc {
		var index:int = descIndexMap$class[clazz];
		return descList[index];
	}

}

}
