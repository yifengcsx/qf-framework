/**
 * Created by 毅峰 on 14-1-6.
 */
package com.qf.framework.common.enum {
import com.qf.framework.common.reflect.Type;

import flash.utils.Dictionary;

/**
 * 枚举存储空间
 *
 * @author 毅峰
 */
internal class EnumSpace {

	//noinspection ReservedWordAsName
	internal var type:Type;
	internal var enumMap$Name:Dictionary = new Dictionary();
	internal var enumMap$ID:Array = [];
	private var enumList:Vector.<Enum>;

	internal function getEnumList():Vector.<Enum> {
		if (!enumList) {
			enumList = new Vector.<Enum>();
			for each (var e:Enum in enumMap$ID) {
				e && (enumList.push(e));
			}
		}
		return enumList;
	}

	internal function getEnumTypeName():String {
		return type.getFullName();
	}

}
}
