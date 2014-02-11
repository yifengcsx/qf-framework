package com.qf.framework.ioc.injection {
import com.qf.framework.common.reflect.Type;

/**
 * 注入信息
 *
 * @author 毅峰
 */
public class InjectionInfo {

	/**
	 * 构建新实例
	 *
	 * @param type      对应的类型
	 * @param points    注入点
	 */
	public function InjectionInfo(type:Type, points:Vector.<InjectionPoint>) {
		this.type = type;
		this.points = points;
	}

	private var type:Type;
	private var points:Vector.<InjectionPoint>;

	/**
	 * 获得类型
	 *
	 * @return
	 */
	public function getType():Type {
		return type;
	}

	/**
	 * 获得所有注入点
	 *
	 * @return
	 */
	public function getInjectionPoints():Vector.<InjectionPoint> {
		return points;
	}
}
}
