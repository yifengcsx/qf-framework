package com.qf.framework.common.reflect.util {
import com.qf.framework.common.reflect.util.json.*;

/**
 * 原始类型描述提供器
 *
 * @author 毅峰
 */
public interface RawTypeDescProvider {

	/**
	 * 提供指定类的原始描述
	 *
	 * @param clazz
	 * @return
	 */
	function provide(clazz:Class):RawTypeDesc;

}
}
