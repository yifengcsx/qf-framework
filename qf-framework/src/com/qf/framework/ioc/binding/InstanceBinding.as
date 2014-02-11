package com.qf.framework.ioc.binding {
import com.qf.framework.common.util.checkNotNull;
import com.qf.framework.ioc.Key;

/**
 *
 *
 * @author 毅峰
 */
public class InstanceBinding implements Binding {

	public function InstanceBinding(key:Key, ins:Object) {
		checkNotNull(ins, "缺少绑定的实例!");
		this.key = key;
		this.ins = ins;
	}

	private var key:Key;
	private var ins:Object;

	public function getKey():Key {
		return key;
	}

	public function provide():* {
		return ins;
	}

}
}
