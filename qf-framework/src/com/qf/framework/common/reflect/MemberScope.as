package com.qf.framework.common.reflect {
import com.qf.framework.common.enum.Enum;

/**
 * 成员范围
 *
 * @author 毅峰
 */
public class MemberScope extends Enum {

	/** 实例中 */
	public static const INSTANCE:MemberScope = new MemberScope("INSTANCE", 1);
	/** 在类中 */
	public static const CLASS:MemberScope = new MemberScope("CLASS", 2);
	/** 所有 */
	public static const All:MemberScope = new MemberScope("All", 3);

	public function MemberScope(name:String, ID:uint) {
		super(name, ID);
	}


}

}
