package {

/**
 *fdsafdsa
 *
 * @author 毅峰
 */
public class Class1 implements Interface1 {

	[QF_Inject(optional="true")]
	public var field1:Interface2;
	[QF_Inject]
	public var field2:Interface2;
	[QF_Inject]
	public var field3:Interface2;
	[QF_Inject]
	[QF_Named(name="name1")]
	public var field4:Interface2;

	public function Class1(p1:Interface2) {
		trace("正在创建Class1");
		trace("--构造参数:", p1);
	}

	public function getField1():Interface2 {
		return field1;
	}

	[QF_InjectMethod]
	public function m1():void {
		trace("方法注入，无参数");
	}

	[QF_InjectMethod]
	[QF_ParamNamed(index="0", name="name1")]
	public function m2(obj1:Interface2):void {
		trace("方法注入，有参数:", obj1);
	}

	public function toString():String {
		return "Class1{field1=" + String(field1) + ",field2=" + String(field2) + ",field3=" + String(field3) +
		       ",field4=" + String(field4) + "}";
	}

	[QF_InitCompleted]
	public function afterInit():void {
		trace("Class1初始化完毕!!!!", this);
	}

}
}
