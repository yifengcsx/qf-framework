package com.qf.framework.common.util {
/**
 * 回调
 *
 * @author 毅峰
 */
public final class Callback {

	/**
	 * 创建一个回调
	 *
	 * @param fun       回调执行方法
	 * @param source    方法源，如果为匿名方法，则this对象为此对象
	 * @param data      可以按自己需求存放数据，在回调执行是可以获得
	 * @return
	 */
	public static function create(fun:Function, source:* = null, data:* = null):Callback {
		checkNotNull(fun);
		var cb:Callback = new Callback();
		cb.fun = fun;
		cb.source = source;
		cb.data = data;
		cb.paramNum = fun.length;
		return cb;
	}

	public function Callback() {}

	private var source:*;
	private var data:*;
	private var result:*;
	private var fun:Function;
	private var paramNum:uint;

	public function getSource():* {
		return source;
	}

	public function getData():* {
		return data;
	}

	public function getResult():* {
		return result;
	}

	/**
	 * 调用
	 *
	 * @param result
	 */
	public function invoke(result:*):void {
		this.result = result;
		if (paramNum == 0) {
			fun.call(source);
		} else {
			fun.call(source, this);
		}
		source = null;
		data = null;
		fun = null;
		result = null;
	}

}
}
