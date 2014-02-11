package com.qf.framework.core.ioc.binding {
import com.qf.framework.core.ioc.*;

/**
 * 配置
 *
 * @author 毅峰
 */
public interface Config {

	/**
	 * 进行配置
	 *
	 * @param injector 注入器
	 */
	function configure(injector:Injector):void;

}
}
