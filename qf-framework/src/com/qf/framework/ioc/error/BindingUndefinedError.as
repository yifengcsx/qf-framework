package com.qf.framework.ioc.error {

/**
 * 绑定未定义错误
 *
 * @author 毅峰
 */
public class BindingUndefinedError extends Error {

	/**
	 * 绑定未定义错误
	 */
	public function BindingUndefinedError() {
		super("绑定未定义!");
	}
}
}
