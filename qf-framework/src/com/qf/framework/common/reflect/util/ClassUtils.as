package com.qf.framework.common.reflect.util {

import com.qf.framework.common.error.ClassNotFoundError;
import com.qf.framework.common.error.ErrorCenter;
import com.qf.framework.common.reflect.util.json.JSONRawTypeDescProvider;
import com.qf.framework.common.util.StringUtils;
import com.qf.framework.common.util.isNotNull;
import com.qf.framework.common.util.isNull;

import flash.system.ApplicationDomain;
import flash.utils.Proxy;
import flash.utils.getQualifiedClassName;

public final class ClassUtils {

	private static const AS3VEC_SUFFIX:String = "__AS3__.vec";
	private static const CONSTRUCTOR_FIELD_NAME:String = "constructor";
	private static const LESS_THAN:String = "<";
	private static const PACKAGE_CLASS_SEPARATOR:String = "::";

	private static var rawTypeDescProvider:RawTypeDescProvider;

	public static function getRawTypeDescProvider():RawTypeDescProvider {
		if (!rawTypeDescProvider) {
			rawTypeDescProvider = new JSONRawTypeDescProvider();
		}
		return rawTypeDescProvider;
	}

	public static function setRawTypeDescProvider(v:RawTypeDescProvider):void {
		rawTypeDescProvider = v;
	}

	public static function convertFullyQualifiedName(className:String):String {
		return className.replace(PACKAGE_CLASS_SEPARATOR, ".");
	}

	public static function getClassByInstance(instance:*, applicationDomain:ApplicationDomain = null):Class {
		if ((!(instance is Proxy)) && (instance.hasOwnProperty(CONSTRUCTOR_FIELD_NAME))) {
			return instance[CONSTRUCTOR_FIELD_NAME];
		} else {
			var className:String = getQualifiedClassName(instance);
			return getClassByName(className, applicationDomain);
		}
	}

	public static function getClassByName(name:String, appDomain:ApplicationDomain = null):Class {
		appDomain ||= ApplicationDomain.currentDomain;
		var result:Class;
		while (!appDomain.hasDefinition(name)) {
			if (appDomain.parentDomain) {
				appDomain = appDomain.parentDomain;
			} else {
				break;
			}
		}
		try {
			result = appDomain.getDefinition(name) as Class;
		} catch (e:Error) {
		}
		if (isNull(result)) {
			ErrorCenter.get().throwError(new ClassNotFoundError(name));
		}
		return result;
	}

	public static function getGenericityClassByVectorName(vectorClassName:String, applicationDomain:ApplicationDomain = null):Class {
		if (StringUtils.startsWith(vectorClassName, AS3VEC_SUFFIX)) {
			var startIdx:int = vectorClassName.indexOf(LESS_THAN) + 1;
			var len:int = (vectorClassName.length - startIdx) - 1;
			var className:String = vectorClassName.substr(startIdx, len);
			return getClassByName(className, applicationDomain);
		} else {
			return null;
		}
	}

	public static function getFullNameByClass(clazz:Class):String {
		return getQualifiedClassName(clazz);
	}


	public static function getImplementedInterfaces(clazz:Class, appDomain:ApplicationDomain = null):Vector.<Class> {
		appDomain ||= ApplicationDomain.currentDomain;
		var typeDesc:RawTypeDesc = getRawTypeDesc(clazz, appDomain);
		var result:Vector.<Class> = new <Class>[];
		for each (var interfaceName:String in typeDesc.getInterfaces()) {
			result.push(getClassByName(interfaceName, appDomain));
		}
		return result;
	}

	public static function getName(clazz:Class):String {
		return getNameFromFullName(getFullNameByClass(clazz));
	}

	public static function getNameFromFullName(fullyQualifiedName:String):String {
		var startIndex:int = fullyQualifiedName.indexOf(PACKAGE_CLASS_SEPARATOR);
		if (startIndex == -1) {
			return fullyQualifiedName;
		} else {
			return fullyQualifiedName.substring(startIndex + PACKAGE_CLASS_SEPARATOR.length, fullyQualifiedName.length);
		}
	}

	public static function getProperties(clazz:Class, statik:Boolean = false, access:String = AccessType.READ_WRITE, appDomain:ApplicationDomain = null):Vector.<RawPropertyDesc> {
		var typeDesc:RawTypeDesc = getRawTypeDesc(clazz, appDomain);
		var vars:Vector.<RawVariableDesc>;
		var accessors:Vector.<RawAccessorDesc>;
		if (statik) {
			vars = typeDesc.getStaticVariables();
			accessors = typeDesc.getStaticAccessors();
		} else {
			vars = typeDesc.getVariables();
			accessors = typeDesc.getAccessors();
		}
		var result:Vector.<RawPropertyDesc> = new <RawPropertyDesc>[];
		for each (var rawVariableDesc:RawPropertyDesc in vars) {
			if (rawVariableDesc.getAccess() == access) {
				result.push(rawVariableDesc);
			}
		}
		for each (var rawAccessorDesc:RawAccessorDesc in accessors) {
			if (rawAccessorDesc.getAccess() == access) {
				result.push(rawAccessorDesc);
			}
		}
		return result;
	}


	public static function getSuperClass(clazz:Class, appDomain:ApplicationDomain = null):Class {
		var typeDesc:RawTypeDesc = getRawTypeDesc(clazz, appDomain);
		if (typeDesc.getSuperClasses() && typeDesc.getSuperClasses().length > 0) {
			return getClassByName(typeDesc.getSuperClasses()[0]);
		}
		return null;
	}

	public static function isAssignableFrom(clazz1:Class, clazz2:Class, appDomain:ApplicationDomain = null):Boolean {
		return (clazz1 === clazz2) || isSubclassOf(clazz2, clazz1, appDomain) || isImplementationOf(clazz2, clazz1, appDomain);
	}

	public static function isImplementationOf(clazz:Class, interfaceClass:Class, appDomain:ApplicationDomain = null):Boolean {
		var typeDesc:RawTypeDesc = getRawTypeDesc(clazz, appDomain);
		var interfaceTypeDesc:RawTypeDesc = getRawTypeDesc(interfaceClass, appDomain);
		return typeDesc.getInterfaces()
				&& typeDesc.getInterfaces().indexOf(interfaceTypeDesc.getName()) != -1;
	}


	public static function isInterface(clazz:Class):Boolean {
		if (clazz === Object)
			return false;
		var typeDesc:RawTypeDesc = getRawTypeDesc(clazz, ApplicationDomain.currentDomain);
		return typeDesc.getSuperClasses().length == 0;
	}


	public static function isSubclassOf(clazz:Class, superClass:Class, appDomain:ApplicationDomain = null):Boolean {
		var typeDesc:RawTypeDesc = getRawTypeDesc(clazz, appDomain);
		var superTypeDesc:RawTypeDesc = getRawTypeDesc(superClass, appDomain);
		return typeDesc.getSuperClasses()
				&& typeDesc.getSuperClasses().indexOf(superTypeDesc.getName()) != -1;
	}

	public static function newInstance(clazz:Class, args:Array = null):* {
		if (isNotNull(args)) {
			switch (args.length) {
				case 1:
					return new clazz(args[0]);
				case 2:
					return new clazz(args[0], args[1]);
				case 3:
					return new clazz(args[0], args[1], args[2]);
				case 4:
					return new clazz(args[0], args[1], args[2],
							args[3]);
				case 5:
					return new clazz(args[0], args[1], args[2],
							args[3], args[4]);
				case 6:
					return new clazz(args[0], args[1], args[2],
							args[3], args[4], args[5]);
				case 7:
					return new clazz(args[0], args[1], args[2],
							args[3], args[4], args[5], args[6]);
				case 8:
					return new clazz(args[0], args[1], args[2],
							args[3], args[4], args[5], args[6],
							args[7]);
				case 9:
					return new clazz(args[0], args[1], args[2],
							args[3], args[4], args[5], args[6],
							args[7], args[8]);
				case 10:
					return new clazz(args[0], args[1], args[2],
							args[3], args[4], args[5], args[6],
							args[7], args[8], args[9]);
			}
		}
		return new clazz();
	}


	public static function getRawTypeDesc(object:Object, appDomain:ApplicationDomain = null):RawTypeDesc {
		// ================== 获得Class
		var clazz:Class;
		if (object is Class) {
			clazz = object as Class;
		} else {
			var className:String = getQualifiedClassName(object);
			if (object.hasOwnProperty(CONSTRUCTOR_FIELD_NAME)) {
				clazz = object.constructor;
			} else {
				clazz = getClassByName(className, appDomain);
			}
		}
		// ================== 获得描述
		var rawTypeDesc:RawTypeDesc;
		// 优先查找缓存
		if (RawTypeDescCache.get().hasByClass(clazz)) {
			rawTypeDesc = RawTypeDescCache.get().getByClass(clazz);
		} else {
			rawTypeDesc = getRawTypeDescProvider().provide(clazz);
			RawTypeDescCache.get().add(rawTypeDesc);
		}
		return rawTypeDesc;
	}


}
}
