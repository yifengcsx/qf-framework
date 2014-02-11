package com.qf.framework.common.error {

/**
 * 空指针错误
 *
 * @author 毅峰
 */
public class NullPointerError extends Error {

	public function NullPointerError(message:String = null) {
		message ||= "";
		super("空指针错误:" + message);
	}

}
}
