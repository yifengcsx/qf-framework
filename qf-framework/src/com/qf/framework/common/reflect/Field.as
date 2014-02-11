package com.qf.framework.common.reflect {
import com.qf.framework.common.reflect.util.RawPropertyDesc;

/**
 * 类字段(包括静态和非静态变量和getter、setter)
 *
 * @author 毅峰
 */
public class Field extends AbstractMetadataOwner implements Member {

	public function Field(owner:Type, propertyDesc:RawPropertyDesc, static_:Boolean) {
		super(propertyDesc.getMetadatas());
		this.name = propertyDesc.getName();
		this.owner = owner;
		this.static_ = static_;
		this.accessType = FieldAccessType.forRawAccess(propertyDesc.getAccess());
		this.propertyDesc = propertyDesc;
	}

	private var name:String;
	private var owner:Type;
	private var static_:Boolean;
	private var accessType:FieldAccessType;
	private var type_:Type;

	private var propertyDesc:RawPropertyDesc;

	public function getName():String {
		return name;
	}

	public function getOwner():Type {
		return owner;
	}

	public function isStatic():Boolean {
		return static_;
	}

	public function getAccessType():FieldAccessType {
		return accessType;
	}

	public function getType():Type {
		if (!type_) {
			type_ = Type.forClassName(propertyDesc.getType());
		}
		return type_;
	}

	public function setValue(obj:Object, v:Object):void {
		obj[getName()] = v;
	}

	public function getValue(obj:Object):* {
		return obj[getName()];
	}

	public function toString():String {
		return "Field{name=" + getName()
				       + ",static=" + isStatic()
				       + ",accessType=" + getAccessType().toString()
				       + ",metadatas=" + getMetadatas().join()
				+ "}";
	}
}
}
