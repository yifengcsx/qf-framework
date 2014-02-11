package com.qf.framework.common.reflect {

/**
 * 元数据容器
 *
 * @author 毅峰
 */
public interface MetadataOwner {

	/**
	 * 是否有指定的元数据
	 *
	 * @param name 是否有指定名称的元数据
	 * @return
	 */
	function hasMetadata(name:String):Boolean;

	/**
	 * 获得指定名称的元数据
	 *
	 * @param name  元数据名称
	 * @return      如果没有此名称元素局则返回null
	 */
	function getMetadatasByName(name:String):Vector.<Metadata>;

	/**
	 * 获得所有元数据
	 */
	function getMetadatas():Vector.<Metadata>;

	/**
	 * 获得某个名字的首个元数据
	 *
	 * @param name  元数据名称
	 * @return      如果没有此名称元素局则返回null
	 */
	function getFirstMetadataByName(name:String):Metadata;

}
}
