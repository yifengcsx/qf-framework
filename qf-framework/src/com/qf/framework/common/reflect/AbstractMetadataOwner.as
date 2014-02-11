/**
 * Created by 毅峰 on 14-1-7.
 */
package com.qf.framework.common.reflect {
import com.qf.framework.common.reflect.util.RawMetadataDesc;

import flash.utils.Dictionary;

/**
 * 抽象元数据容器
 *
 * @author 毅峰
 */
public class AbstractMetadataOwner implements MetadataOwner {

	private static const EXCLUDES:Object = {
		__go_to_definition_help     : null,
		__go_to_ctor_definition_help: null
	};

	public function AbstractMetadataOwner(metadataDescList:Vector.<RawMetadataDesc>) {
		this.metadataDescList = metadataDescList;
	}

	private var metadataList:Vector.<Metadata>;
	private var metadataListMap:Dictionary;
	private var firstMetadataMap:Dictionary;

	private var inited:Boolean = false;
	private var metadataDescList:Vector.<RawMetadataDesc>;

	public function hasMetadata(name:String):Boolean {
		checkInit();
		return name in metadataListMap;
	}

	public function getMetadatasByName(name:String):Vector.<Metadata> {
		checkInit();
		return metadataListMap[name];
	}

	public function getMetadatas():Vector.<Metadata> {
		checkInit();
		return metadataList;
	}

	public function getFirstMetadataByName(name:String):Metadata {
		checkInit();
		return firstMetadataMap[name];
	}

	[Inline]
	private final function checkInit():void {
		if (!inited) {
			metadataList = new <Metadata>[];
			metadataListMap = new Dictionary();
			firstMetadataMap = new Dictionary();
			for each (var metadataDesc:RawMetadataDesc in metadataDescList) {
				if (metadataDesc.getName() in EXCLUDES) {
					continue;
				}
				var metadata:Metadata = new Metadata(metadataDesc);
				metadataList.push(metadata);
				var listForName:Vector.<Metadata> = metadataListMap[metadata.getName()];
				if (!listForName) {
					listForName = new <Metadata>[];
					metadataListMap[metadata.getName()] = listForName;
					firstMetadataMap[metadata.getName()] = metadata;
				}
				listForName.push(metadata);
			}
			inited = true;
		}
	}

}

}
