package com.qf.framework.core.ioc.binding {
import com.qf.framework.core.ioc.*;

/**
 * 提供器绑定
 *
 * @author 毅峰
 */
public class ProviderBinding implements Binding {

	public function ProviderBinding(key:Key, provider:Provider) {
		this.key = key;
		this.provider = provider;
	}

	private var key:Key;
	private var provider:Provider;

	public function getKey():Key {
		return key;
	}

	public function provide():* {
		return provider.get();
	}

	public function getProvider():Provider {
		return provider;
	}

}
}
