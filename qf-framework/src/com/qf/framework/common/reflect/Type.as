package com.qf.framework.common.reflect {
import com.qf.framework.common.base.Equality;
import com.qf.framework.common.base.Identity;
import com.qf.framework.common.error.ErrorCenter;
import com.qf.framework.common.error.InstantiationError;
import com.qf.framework.common.reflect.util.ClassUtils;
import com.qf.framework.common.reflect.util.RawAccessorDesc;
import com.qf.framework.common.reflect.util.RawMethodDesc;
import com.qf.framework.common.reflect.util.RawParamDesc;
import com.qf.framework.common.reflect.util.RawTypeDesc;
import com.qf.framework.common.reflect.util.RawVariableDesc;
import com.qf.framework.common.util.IDs;
import com.qf.framework.common.util.isEqual;

import flash.system.ApplicationDomain;

/**
 * 类型
 *
 * @author 毅峰
 */
public final class Type extends AbstractMetadataOwner implements Equality,Identity {

	private static const ID_SPACE_NAME:String = "type_id";

	private static var _void:Type;

	public static function get VOID():Type {
		if (!_void) {
			_void = forClass(Void);
			_void.fullName = "void";
			_void.name = "void";
		}
		return _void;
	}

	private static var _untyped:Type;

	public static function get UNTYPED():Type {
		if (!_untyped) {
			_untyped = forClass(Untyped);
			_untyped.fullName = "*";
			_untyped.name = "*";
		}
		return _untyped;
	}

	private static var locked:Boolean = true;

	/**
	 * 通过类名获得实例
	 *
	 * @param className 类名全名，如：con.abc.test::Class1
	 * @param appDomain
	 * @return
	 */
	public static function forClassName(className:String, appDomain:ApplicationDomain = null):Type {
		if (isEqual(className, "void")) {
			return VOID;
		} else if (isEqual(className, "*")) {
			return UNTYPED;
		}
		if (TypeCache.get().hasByClassName(className)) {
			return TypeCache.get().getByName(className);
		}
		return forClass(ClassUtils.getClassByName(className, appDomain), appDomain);
	}

	/**
	 * 通过Class对象获得实例
	 *
	 * @param clazz
	 * @param appDomain
	 * @return
	 */
	public static function forClass(clazz:Class, appDomain:ApplicationDomain = null):Type {
		if (TypeCache.get().hasByClass(clazz)) {
			return TypeCache.get().getByClass(clazz);
		}
		locked = false;
		var result:Type = new Type(clazz, appDomain);
		TypeCache.get().add(result);
		return result;
	}

	/**
	 * 通过相应类型实例获得实例
	 *
	 * @param ins
	 * @param appDomain
	 * @return
	 */
	public static function forInstance(ins:Object, appDomain:ApplicationDomain = null):Type {
		var clazz:Class = ClassUtils.getClassByInstance(ins, appDomain);
		return forClass(clazz, appDomain);
	}

	public function Type(clazz:Class, appDomain:ApplicationDomain = null) {
		if (!locked) {
			locked = true;
			this.typeDesc = ClassUtils.getRawTypeDesc(clazz, appDomain);
			this.fullName = this.typeDesc.getName();
			this.id = IDs.create(ID_SPACE_NAME);
			super(typeDesc.getMetadatas());
		} else {
			ErrorCenter.get().throwError(new InstantiationError("请调用静态方法获得实例!"));
		}
	}

	private var id:uint;
	private var fullName:String;
	private var name:String;
	private var typeDesc:RawTypeDesc;
	private var interface_:uint = 2;

	private var constructorParams:Vector.<MethodParam>;
	private var fieldList:Vector.<Field>;
	private var staticFieldList:Vector.<Field>;
	private var methodList:Vector.<Method>;
	private var staticMethodList:Vector.<Method>;

	public function equal(obj:*):Boolean {
		if (this == obj) {
			return true;
		} else if (obj is Type) {
			return this.getID() == Type(obj).getID();
		}
		return false;
	}

	public function getID():uint {
		return id;
	}

	/**
	 * 获得完整类名，如：com.abc.test::Class1
	 *
	 * @return
	 */
	public function getFullName():String {
		return fullName;
	}

	/**
	 * 获得类名，但不包括包，如：
	 * <code>
	 *     com.abc.test::Class1 -> Class1
	 * </code>
	 * @return
	 */
	public function getName():String {
		if (!name) {
			var i:int = fullName.indexOf("::");
			if (i >= 0) {
				name = fullName.substring(i + 2);
			} else {
				name = fullName;
			}
		}
		return name;
	}

	/**
	 * 获得此类型对应的Class
	 *
	 * @return
	 */
	public function getClass():Class {
		return typeDesc.getClass();
	}

	public function getConstructorParams():Vector.<MethodParam> {
		if (!constructorParams) {
			constructorParams = new <MethodParam>[];
			var i:int = 0;
			for each (var paramDesc:RawParamDesc in typeDesc.getConstructor()) {
				constructorParams.push(new MethodParam(paramDesc, i))
			}
		}
		return constructorParams;
	}

	public function newInstance(args:Array = null):* {
		if (isInterface()) {
			ErrorCenter.get().throwError(new InstantiationError("接口不能实例化!"))
		}
		return ClassUtils.newInstance(getClass(), args);
	}

	public function getField(name:String, scope:MemberScope = null):Field {
		scope ||= MemberScope.INSTANCE;
		if (scope.isIn(MemberScope.INSTANCE, MemberScope.All)) {
			checkField();
			return findMemberByNameIn(fieldList, name);
		}
		if (scope.isIn(MemberScope.CLASS, MemberScope.All)) {
			checkStaticField();
			return findMemberByNameIn(staticFieldList, name);
		}
		return null;
	}

	public function getFields(scope:MemberScope = null):Vector.<Field> {
		scope ||= MemberScope.INSTANCE;
		switch (scope) {
			case MemberScope.INSTANCE:
				checkField();
				return fieldList;
			case MemberScope.CLASS:
				checkStaticField();
				return staticFieldList;
			case MemberScope.All:
				checkField();
				checkStaticField();
				return fieldList.concat(staticFieldList);
		}
		return null;
	}

	public function hasField(name:String, scope:MemberScope = null):Boolean {
		return getField(name, scope) != null;
	}

	public function getMethod(name:String, scope:MemberScope = null):Method {
		scope ||= MemberScope.INSTANCE;
		if (scope.isIn(MemberScope.INSTANCE, MemberScope.All)) {
			checkMethod();
			return findMemberByNameIn(methodList, name);
		}
		if (scope.isIn(MemberScope.CLASS, MemberScope.All)) {
			checkStaticMethod();
			return findMemberByNameIn(staticMethodList, name);
		}
		return null;
	}

	public function getMethods(scope:MemberScope = null):Vector.<Method> {
		scope ||= MemberScope.INSTANCE;
		switch (scope) {
			case MemberScope.INSTANCE:
				checkMethod();
				return methodList;
			case MemberScope.CLASS:
				checkStaticMethod();
				return staticMethodList;
			case MemberScope.All:
				checkMethod();
				checkStaticMethod();
				return methodList.concat(staticMethodList);
		}
		return null;
	}

	public function hasMethod(name:String, scope:MemberScope = null):Boolean {
		return getMethod(name, scope) != null;
	}

	public function getMember(name:String, scope:MemberScope = null):Member {
		var member:Member = getField(name, scope);
		if (!member) {
			member = getMethod(name, scope);
		}
		return member;
	}

	public function getMembers(scope:MemberScope = null):Vector.<Member> {
		return new Vector.<Member>().concat(getFields(scope)).concat(getMethods(scope));
	}

	public function hasMember(name:String, scope:MemberScope = null):Boolean {
		return getMember(name, scope) != null;
	}

	/**
	 * 是否为接口
	 *
	 * @return
	 */
	public function isInterface():Boolean {
		if (interface_ == 2) {
			if (ClassUtils.isInterface(getClass())) {
				interface_ = 1;
			} else {
				interface_ = 0;
			}
		}
		return interface_ == 1;
	}

	[Inline]
	private final function checkField():void {
		if (!fieldList) {
			fieldList = new <Field>[];
			// 变量
			for each (var varDesc:RawVariableDesc in typeDesc.getVariables()) {
				fieldList.push(new Field(this, varDesc, false));
			}
			// 访问器
			for each (var accessorDesc:RawAccessorDesc in typeDesc.getAccessors()) {
				fieldList.push(new Field(this, accessorDesc, false));
			}
		}
	}

	[Inline]
	private final function checkStaticField():void {
		if (!staticFieldList) {
			staticFieldList = new <Field>[];
			// 变量
			for each (var varDesc:RawVariableDesc in typeDesc.getStaticVariables()) {
				staticFieldList.push(new Field(this, varDesc, true));
			}
			// 访问器
			for each (var accessorDesc:RawAccessorDesc in typeDesc.getStaticAccessors()) {
				staticFieldList.push(new Field(this, accessorDesc, true));
			}
		}
	}

	[Inline]
	private final function checkMethod():void {
		if (!methodList) {
			methodList = new <Method>[];
			for each (var methodDesc:RawMethodDesc in typeDesc.getMethods()) {
				methodList.push(new Method(this, methodDesc, false));
			}
		}
	}

	[Inline]
	private final function checkStaticMethod():void {
		if (!staticMethodList) {
			staticMethodList = new <Method>[];
			for each (var methodDesc:RawMethodDesc in typeDesc.getStaticMethods()) {
				methodList.push(new Method(this, methodDesc, true));
			}
		}
	}

	[Inline]
	private final function findMemberByNameIn(members:*, name:String):* {
		for each (var member:Member in members) {
			if (isEqual(member.getName(), name)) {
				return member;
			}
		}
		return null;
	}

}
}
