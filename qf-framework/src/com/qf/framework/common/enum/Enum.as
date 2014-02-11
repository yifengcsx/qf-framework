/**
 * Created by 毅峰 on 14-1-6.
 */
package com.qf.framework.common.enum {
import com.qf.framework.common.base.Equality;
import com.qf.framework.common.error.EnumNotFoundError;
import com.qf.framework.common.error.ErrorCenter;
import com.qf.framework.common.reflect.Type;
import com.qf.framework.common.util.Arrays;
import com.qf.framework.common.util.checkNotNull;
import com.qf.framework.common.util.isNull;

import flash.utils.Dictionary;

/**
 * 枚举
 *
 * @author 毅峰
 */
public class Enum implements Equality {

	Enum.prototype["enum"] = true;

	private static const ENUM_SPACE_MAP:Dictionary = new Dictionary();

	/**
	 * 获得指定枚举类型的所有枚举项
	 *
	 * @param enumClass 一个继承Enum的Class
	 * @return
	 */
	public static function getValues(enumClass:Class):Vector.<Enum> {
		if (checkClass(enumClass) && hasSpace(enumClass)) {
			var space:EnumSpace = getSpace(enumClass);
			return space.getEnumList();
		}
		return null;
	}

	/**
	 * 获得指定类型和名称的枚举项
	 *
	 * @param enumClass 一个继承Enum的Class
	 * @param name      枚举名称
	 * @param def       默认值(如果找不到则返回此值)
	 * @param allowNull 是否允许找不到枚举
	 * @return
	 */
	public static function getByName(enumClass:Class, name:String, def:Enum = null, allowNull:Boolean = false):* {
		checkNotNull(enumClass);
		checkNotNull(name);
		var result:Enum;
		if (checkClass(enumClass) && hasSpace(enumClass)) {
			var space:EnumSpace = getSpace(enumClass);
			result = space.enumMap$Name[name];
		}
		result ||= def;
		if (!allowNull && isNull(result)) {
			ErrorCenter.get().throwError(new EnumNotFoundError(enumClass, name));
		}
		return result;
	}

	/**
	 * 获得指定类型和ID的枚举项
	 *
	 * @param enumClass 一个继承Enum的Class
	 * @param ID        枚举名称
	 * @param def       默认值(如果找不到则返回此值)
	 * @param allowNull 是否允许找不到枚举
	 * @return
	 */
	public static function getByID(enumClass:Class, ID:uint, def:Enum = null, allowNull:Boolean = false):* {
		checkNotNull(enumClass);
		var result:Enum;
		if (checkClass(enumClass) && hasSpace(enumClass)) {
			var space:EnumSpace = getSpace(enumClass);
			result = space.enumMap$ID[ID];
		}
		result ||= def;
		if (!allowNull && isNull(result)) {
			ErrorCenter.get().throwError(new EnumNotFoundError(enumClass, ID));
		}
		return result;
	}

	private static function checkClass(clazz:Class):Boolean {
		if (clazz.prototype["enum"] !== true) {
			ErrorCenter.get().throwError(new ArgumentError("不是Enum类!"));
		}
		return true;
	}

	private static function getSpace(enumClass:Class):EnumSpace {
		var space:EnumSpace = ENUM_SPACE_MAP[enumClass];
		if (!space) {
			space = new EnumSpace();
			space.type = Type.forClass(enumClass);
			ENUM_SPACE_MAP[enumClass] = space;
		}
		return space;
	}

	private static function hasSpace(enumClass:Class):Boolean {
		return enumClass in ENUM_SPACE_MAP;
	}

	private var name:String;
	private var ID:uint;
	private var space:EnumSpace;

	public function Enum(name:String, ID:uint) {
		this.name = name;
		this.ID = ID;
		init();
	}

	/**
	 * 获得枚举名称
	 */
	public final function getName():String {
		return name;
	}

	/**
	 * 获得枚举ID
	 */
	public final function getID():uint {
		return ID;
	}

	/**
	 * @inheritDoc
	 */
	public final function equal(obj:*):Boolean {
		return obj == this;
	}

	/**
	 * 是否在给定的枚举中
	 *
	 * @param enums
	 * @return
	 */
	public final function isInArray(enums:Array):Boolean {
		if (Arrays.isEmpty(enums)) {
			return false;
		}
		var len:int = enums.length;
		switch (len) {
			case 1:
				return equal(enums[0]);
			case 2:
				return equal(enums[0]) || equal(enums[1]);
			case 3:
				return equal(enums[0]) || equal(enums[1]) || equal(enums[2]);
			case 4:
				return equal(enums[0]) || equal(enums[1]) || equal(enums[2]) || equal(enums[3]);
			case 5:
				return equal(enums[0]) || equal(enums[1]) || equal(enums[2]) || equal(enums[3]) || equal(enums[4]);
		}
		for (var i:int = 5; i < len; i++) {
			if (equal(enums[i])) {
				return true;
			}
		}
		return false;
	}

	/**
	 * 是否在给定的枚举中
	 *
	 * @param e1
	 * @param e2
	 * @param e3
	 * @param e4
	 * @return
	 */
	public final function isIn(e1:Enum, e2:Enum = null, e3:Enum = null, e4:Enum = null):Boolean {
		return (equal(e1) || equal(e2) || equal(e3) || equal(e4));
	}


	[Inline]
	private final function init():void {
		var c:* = Object(this).constructor;
		space = getSpace(c);
		space.enumMap$Name[name] = this;
		space.enumMap$ID[ID] = this;
	}

	public function toString():String {
		return space.getEnumTypeName() + "." + name;
	}


}
}

