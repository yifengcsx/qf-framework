package com.qf.framework.common.reflect {
import flash.utils.Dictionary;

/**
 * 类型缓存
 *
 * @author 毅峰
 */
internal class TypeCache {

	private static const INS:TypeCache = new TypeCache();

	public static function get():TypeCache {
		return INS;
	}

	private var typeList:Vector.<Type> = new <Type>[];
	private var typeIndexMap$name:Dictionary = new Dictionary();
	private var typeIndexMap$class:Dictionary = new Dictionary();

	public function TypeCache() {
	}

	public function add(type_:Type):void {
		if (!hasByClass(type_.getClass())) {
			var newIndex:int = typeList.length;
			typeList[newIndex] = type_;
			typeIndexMap$name[type_.getFullName()] = newIndex;
			typeIndexMap$class[type_.getClass()] = newIndex;
		}
	}

	public function hasByClassName(name:String):Boolean {
		return name in typeIndexMap$name;
	}

	public function hasByClass(clazz:Class):Boolean {
		return clazz in typeIndexMap$class;
	}

	public function getByName(name:String):Type {
		var index:int = typeIndexMap$name[name];
		return typeList[index];
	}

	public function getByClass(clazz:Class):Type {
		var index:int = typeIndexMap$class[clazz];
		return typeList[index];
	}

}
}
