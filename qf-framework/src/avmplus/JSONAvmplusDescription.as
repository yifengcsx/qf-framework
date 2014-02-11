package avmplus {

public class JSONAvmplusDescription {
	//----------------------              Public Properties             ----------------------//

	public static var available:Boolean = describeTypeJSON != null;

	public static const INSTANCE_FLAGS:uint = INCLUDE_BASES | INCLUDE_INTERFACES
			| INCLUDE_VARIABLES | INCLUDE_ACCESSORS | INCLUDE_METHODS | INCLUDE_METADATA
			| INCLUDE_CONSTRUCTOR | INCLUDE_TRAITS | USE_ITRAITS | HIDE_OBJECT;

	public static const CLASS_FLAGS:uint = INCLUDE_INTERFACES | INCLUDE_VARIABLES
			| INCLUDE_ACCESSORS | INCLUDE_METHODS | INCLUDE_METADATA | INCLUDE_TRAITS | HIDE_OBJECT;

	public static const CLASS_FLAGS2:uint = INCLUDE_VARIABLES
			| INCLUDE_ACCESSORS | INCLUDE_METHODS | INCLUDE_TRAITS | HIDE_OBJECT;

	//----------------------               Public Methods               ----------------------//
	public function JSONAvmplusDescription() {
	}

	public function getDescriptionJSON(target:Object, flags:uint):Object {
		return describeTypeJSON(target, flags);
	}

	public function getInstanceDescriptionJSON(type:Class):Object {
		return describeTypeJSON(type, INSTANCE_FLAGS);
	}

	public function getClassDescriptionJSON(type:Class):Object {
		return describeTypeJSON(type, CLASS_FLAGS2);
	}
}
}