package com.qf.framework.core.ioc.error {

/**
 * 绑定重复错误
 *
 * @author 毅峰
 */
public class BindRepetitionError extends Error {

	/**
	 * 绑定重复错误
	 */
	public function BindRepetitionError() {
		super("绑定重复!");
	}

}
}
