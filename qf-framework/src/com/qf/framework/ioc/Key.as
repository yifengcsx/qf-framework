package com.qf.framework.ioc {
import com.qf.framework.common.base.Equality;
import com.qf.framework.common.base.Identity;
import com.qf.framework.common.reflect.Type;
import com.qf.framework.common.util.IDs;
import com.qf.framework.common.util.checkNotNull;

/**
 * 绑定的Key
 *
 * @author 毅峰
 */
public final class Key implements Equality, Identity {

	private static const ID_SPACE_NAME:String = "com.qf.framework.core.ioc.Key::ID_SPACE_NAME";

	private static const KEY_CACHE:Object = {};

	public static function forType(type:Type, name:String = null):Key {
		checkNotNull(type);
		var keyName:String = type.getFullName();
		if (name) {
			keyName += "|" + name;
		}
		if (keyName in KEY_CACHE) {
			return KEY_CACHE[keyName];
		}
		var newKey:Key = new Key();
		KEY_CACHE[keyName] = newKey;
		return newKey;
	}

	public function Key() {
		ID = IDs.create(ID_SPACE_NAME);
	}

	private var ID:uint;

	public function getID():uint {
		return ID;
	}

	public function equal(obj:*):Boolean {
		if (obj is Key) {
			return this == obj ||
			       this.getID() == Key(obj).getID();
		}
		return false;
	}

	public function toString():String {
		return "Key{ID=" + getID() + "}";
	}
}
}
