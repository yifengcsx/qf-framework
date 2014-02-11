package com.qf.framework.core {
import com.qf.framework.core.ioc.*;

import flash.system.ApplicationDomain;

/**
 * 框架入口
 *
 * @author 毅峰
 */
public class QF {

	/**
	 * 创建注入器
	 *
	 * @param parent    父注入器
	 * @param appDomain
	 * @return
	 */
	public static function createInjector(parent:Injector = null, appDomain:ApplicationDomain = null):Injector {
		return InjectorBuilder.create().setAppDomain(appDomain).setParent(parent).build();
	}

}
}
