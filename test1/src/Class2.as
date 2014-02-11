package {

/**
 *
 *
 * @author 毅峰
 */
public class Class2 implements Interface2 {

	public function Class2() {
		trace("正在创建Class2");
	}

	public function toString():String {
		return "我是Class2";
	}

	[QF_InitComplete]
	public function afterInit():void {
		trace("Class2初始化完毕!!!!", this);
	}

}
}
