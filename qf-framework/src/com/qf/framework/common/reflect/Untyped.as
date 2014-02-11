package com.qf.framework.common.reflect {
import com.qf.framework.common.error.ErrorCenter;
import com.qf.framework.common.error.InstantiationError;

public class Untyped {
	public function Untyped() {
		ErrorCenter.get().throwError(new InstantiationError("无法实例化不定类型!"));
	}
}
}
