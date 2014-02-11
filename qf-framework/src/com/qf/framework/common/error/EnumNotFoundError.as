package com.qf.framework.common.error {

/**
 * 无法找到指定枚举错误
 *
 * @author 毅峰
 */
public class EnumNotFoundError extends Error {

	public function EnumNotFoundError(enumClass:Class, nameOrID:*) {
		super("无法找到指定枚举:" + enumClass + " -> " + nameOrID);
	}

}
}
