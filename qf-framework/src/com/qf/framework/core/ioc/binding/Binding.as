package com.qf.framework.core.ioc.binding {
import com.qf.framework.core.ioc.Key;

/**
 * 绑定
 *
 * @author 毅峰
 */
public interface Binding {

	/**
	 * 获得绑定Key
	 *
	 * @return
	 */
	function getKey():Key;

	/**
	 * 提供绑定的对象
	 *
	 * @return
	 */
	function provide():*;
}
}
