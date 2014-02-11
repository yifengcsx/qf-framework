package com.qf.framework.common.reflect {
import com.qf.framework.common.enum.Enum;
import com.qf.framework.common.reflect.util.AccessType;

/**
 * 字段访问类型
 *
 * @author 毅峰
 */
public class FieldAccessType extends Enum {

	/** 只读 */
	public static const READ_ONLY:FieldAccessType = new FieldAccessType("READ_ONLY", 1);

	/** 只写 */
	public static const WRITE_ONLY:FieldAccessType = new FieldAccessType("WRITE_ONLY", 2);

	/** 读写 */
	public static const READ_WRITE:FieldAccessType = new FieldAccessType("READ_WRITE", 3);

	/**
	 * 根据原生访问类型获得
	 *
	 * @param access
	 * @return
	 */
	public static function forRawAccess(access:String):FieldAccessType {
		switch (access) {
			case AccessType.READ_ONLY:
				return READ_ONLY;
			case AccessType.WRITE_ONLY:
				return WRITE_ONLY;
			case AccessType.READ_WRITE:
				return READ_WRITE;
		}
		return READ_ONLY;
	}

	public function FieldAccessType(name:String, ID:uint) {
		super(name, ID);
	}


}
}
