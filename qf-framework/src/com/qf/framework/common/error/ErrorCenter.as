package com.qf.framework.common.error {

/**
 *
 *
 * @author 毅峰
 */
public class ErrorCenter {

	private static const INS:ErrorCenter = new ErrorCenter();

	public static function get():ErrorCenter {
		return INS;
	}

	public function ErrorCenter() {
	}

	public function throwError(error:Error):void {
		var aaa:String;
		throw error;
	}

}
}
