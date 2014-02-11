package com.qf.framework.core.ioc.injection {
import com.qf.framework.common.reflect.Type;

import flash.utils.Dictionary;

/**
 *
 *
 * @author 毅峰
 */
internal final class InjectionInfoCache {

	private static const INS:InjectionInfoCache = new InjectionInfoCache();

	public static function get():InjectionInfoCache {
		return INS;
	}

	public function InjectionInfoCache() {}

	private var infoMap:Dictionary = new Dictionary();

	public function add(info:InjectionInfo):void {
		infoMap[info.getType()] = info;
	}

	public function hasByType(type:Type):Boolean {
		return type in infoMap;
	}

	public function getByType(type:Type):InjectionInfo {
		return infoMap[type];
	}

}
}
