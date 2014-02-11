package {
import com.qf.framework.ioc.Injector;
import com.qf.framework.ioc.binding.AbstractConfig;

/**
 *
 *
 * @author 毅峰
 */
public class TestConfig extends AbstractConfig {

	public function TestConfig() {
		super();
	}

	override protected function subConfig(injector:Injector):void {
		bindClass(Interface1).toClass(Class1).asSingleton();
		bindClass(Interface2).toClass(Class2);
		bindClass(Interface2).widthNamed("name1").toClass(Class2_2).asSingleton();
		bindClass(String).widthNamed("str1").toInstance("字符串1");
		bindClass(String).widthNamed("str2").toInstance("字符串2");
	}

}
}
