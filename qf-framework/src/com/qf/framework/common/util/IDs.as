package com.qf.framework.common.util {

/**
 * ID创建工具
 *
 * @author 毅峰
 */
public class IDs {

	private static const GLOBAL_KEY:String = "global_key";

	private static const ID_MAP:Object = {};

	/**
	 * 在指定空间中创建唯一的ID
	 *
	 * @param spaceName 空间名称
	 * @return
	 */
	public static function create(spaceName:String = null):uint {
		spaceName ||= GLOBAL_KEY;
		var id:uint = 0;
		if (spaceName in ID_MAP) {
			id = ID_MAP[spaceName];
		}
		ID_MAP[spaceName] = ++id;
		return id;
	}

}
}
