package com.qf.framework.common.ds.error {
/**
 * 既没有调用 next 也没有调用 previous，或者在最后一次调用 next 或 previous 后调用了 remove 或 add。
 * @author 青竹
 * @email hui161@gmail.com
 */
public class IllegalStateError extends Error {

	public function IllegalStateError() {
		super(" 移除元素失败", 11);
	}
}
}