package com.qf.framework.common.ds.error {
/**
 *当不支持请求的操作时，抛出该异常。
 * @author 青竹
 * @email hui161@gmail.com
 */
public class UnsupportedOperationError extends Error {

	public function UnsupportedOperationError() {
		super("当前不支持此操作", 12);
	}

}
}