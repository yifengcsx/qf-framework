package com.qf.framework.common.util {
import com.qf.framework.common.error.ErrorCenter;
import com.qf.framework.common.error.NullPointerError;

[Inline]
/**
 * 检测指定对象是否为null
 *
 * @param obj
 * @param errorMessage
 * @return
 * @throws NullPointerError
 */
public function checkNotNull(obj:*, errorMessage:String = null):* {
	if (isNull(obj)) {
		ErrorCenter.get().throwError(new NullPointerError(errorMessage))
	}
	return obj;
}

}
