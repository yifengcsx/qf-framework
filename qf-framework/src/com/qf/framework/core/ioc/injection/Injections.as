package com.qf.framework.core.ioc.injection {
import com.qf.framework.common.ds.Map;
import com.qf.framework.common.ds.map.HashMap;
import com.qf.framework.common.reflect.Field;
import com.qf.framework.common.reflect.Metadata;
import com.qf.framework.common.reflect.MetadataOwner;
import com.qf.framework.common.reflect.Method;
import com.qf.framework.common.reflect.MethodParam;
import com.qf.framework.common.reflect.Type;
import com.qf.framework.common.util.checkNotNull;
import com.qf.framework.common.util.isNotNull;
import com.qf.framework.core.ioc.Injector;

/**
 * 注入工具类
 *
 * @author 毅峰
 */
public final class Injections {

	private static const INJECT_FIELD_METADATA_NAME:String /*               */ = "QF_Inject";
	private static const INJECT_FIELD_METADATA_OPTIONAL_NAME:String /*      */ = "optional";
	private static const INJECT_METHOD_METADATA_OPTION_NAME:String /*       */ = "QF_InjectMethod";
	private static const NAMED_METADATA_NAME:String /*                      */ = "QF_Named";
	private static const PARAM_NAMED_METADATA_NAME:String /*                */ = "QF_ParamNamed";
	private static const INIT_COMPLETE_METADATA_NAME:String /*              */ = "QF_InitComplete";

	/**
	 * 获得注入信息
	 *
	 * @param type
	 * @return
	 */
	public static function getInfoByType(type:Type):InjectionInfo {
		checkNotNull(type);
		var cache:InjectionInfoCache = InjectionInfoCache.get();
		if (cache.hasByType(type)) {
			return cache.getByType(type);
		}
		var points:Vector.<InjectionPoint> = new <InjectionPoint>[];
		var metadata:Metadata;
		// 构造
		var constructorParamNameMap:Map = getParamNamedMap(type);
		points.push(new ConstructorInjectionPoint(type, constructorParamNameMap));
		// 字段
		for each (var field:Field in type.getFields()) {
			if (field.hasMetadata(INJECT_FIELD_METADATA_NAME)) {
				metadata = field.getFirstMetadataByName(INJECT_FIELD_METADATA_NAME);
				var option:Boolean = false;
				if (metadata.hasParam(INJECT_FIELD_METADATA_OPTIONAL_NAME)) {
					option = metadata.getParam(INJECT_FIELD_METADATA_OPTIONAL_NAME).getBooleanValue();
				}
				var name:String = null;
				if (field.hasMetadata(NAMED_METADATA_NAME)) {
					name = field.getFirstMetadataByName(NAMED_METADATA_NAME).getParam("name").getRawValue();
				}
				points.push(new FieldInjectionPoint(field, option, name));
			}
		}
		// 方法
		for each (var method:Method in type.getMethods()) {
			if (method.hasMetadata(INJECT_METHOD_METADATA_OPTION_NAME)) {
				var methodParamNameMap:Map = getParamNamedMap(method);
				points.push(new MethodInjectionPoint(method, methodParamNameMap));
			}
		}
		// 初始化完毕方法
		for each (var method2:Method in type.getMethods()) {
			if (method2.hasMetadata(INIT_COMPLETE_METADATA_NAME)) {
				points.push(new MethodInjectionPoint(method2));
				break;
			}
		}
		// 创建注入信息
		var info:InjectionInfo = new InjectionInfo(type, points);
		cache.add(info);
		return info;
	}

	public static function inject(injector:Injector, type:Type, target:Object = null):* {
		var info:InjectionInfo = getInfoByType(type);
		for each (var injectionPoint:InjectionPoint in info.getInjectionPoints()) {
			target = injectionPoint.inject(target, injector);
		}
		return target;
	}

	public static function getParamName(nameMap:Map, methodParam:MethodParam):String {
		if (isNotNull(nameMap) && nameMap.containsKey(methodParam.getIndex())) {
			return nameMap.get(methodParam.getIndex());
		}
		return null;
	}

	private static function getParamNamedMap(mOwner:MetadataOwner):Map {
		var paramNameMap:Map = null;
		if (mOwner.hasMetadata(PARAM_NAMED_METADATA_NAME)) {
			paramNameMap = new HashMap();
			for each (var mpm:Metadata in mOwner.getMetadatasByName(PARAM_NAMED_METADATA_NAME)) {
				paramNameMap.put(mpm.getParam("index").getIntValue(),
				                 mpm.getParam("name").getRawValue());
			}
		}
		return paramNameMap;
	}

}
}
