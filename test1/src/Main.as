package {

import com.qf.framework.core.QF;
import com.qf.framework.core.ioc.Injector;

import flash.display.Sprite;
import flash.events.Event;

public class Main extends Sprite {

	[QF_Inject]
	public var obj1:Interface1;
	[QF_Inject]
	public var obj2:Interface2;
	[QF_Inject]
	public var obj3:Interface1;

	[QF_Inject]
	[QF_Named(name="str1")]
	public var str1:String;

	[QF_Inject]
	[QF_Named(name="str2")]
	public var str2:String;

	[QF_Inject]
	public var inj:Injector;

	public function Main() {
		this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
	}

	[QF_InitCompleted]
	public function initComplete():void {
		trace("主程序初始化完毕!!!");
	}

	private function addedToStageHandler(event:Event):void {
		init();
	}

	private function init():void {
		var rootInjector:Injector = QF.createInjector();
		rootInjector.appendConfigClass(TestConfig);
		// 注入器继承
		var injector:Injector = QF.createInjector(rootInjector);
		injector.injectObject(this);
	}
}
}
