package com.qf.framework.core.ioc.injection {
import com.qf.framework.core.ioc.*;

/**
 * 注入点
 *
 * @author 毅峰
 */
public interface InjectionPoint {

	/**
	 * 注入
	 *
	 * @param target    注入目标
	 * @param injector  注入器
	 * @return          返回处理后的Target对象
	 */
	function inject(target:Object, injector:Injector):Object;

}
}
