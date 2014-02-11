package com.qf.framework.common.error {

/**
 * 实例化错误
 *
 * @author 毅峰
 */
public class InstantiationError extends Error {

	/**
	 * 实例化错误
	 * @param message
	 */
	public function InstantiationError(message:String = null) {
		message ||= "";
		super("实例化错误:" + message);
	}

}
}
