package com.qf.framework.common.ds {
/**
 *将键映射到值的对象。一个映射不能包含重复的键；每个键最多只能映射一个值。
 * @author 青竹
 * @email hui161@gmail.com
 */
public interface Map {
	/**
	 *从移除所有
	 *
	 */
	function clear():void

	/**
	 * 如果此映射包含指定键的映射关系，则返回 true。
	 * @param key 键
	 * @return
	 *
	 */
	function containsKey(key:Object):Boolean ;

	/**
	 * 如果此映射为指定值映射一个或多个键
	 * @param value
	 * @return
	 *
	 */
	function containsValue(value:Object):Boolean;

	/**
	 *比较指定的对象与此映射是否相等。
	 * @param o 比较的对象。
	 * @return
	 *
	 */
	function equals(o:*):Boolean;

	/**
	 * 返回此映射中包含的映射关系的 set 视图。
	 * @see MapEntry
	 * @return
	 *
	 */
	function entrySet():Set;

	/**
	 * 返回此映射中映射到指定键的值。
	 * @param key
	 * @return
	 *
	 */
	function get(key:Object):*;

	/**
	 *如果此映射未包含键-值映射关系，则返回 true。
	 * @return
	 *
	 */
	function isEmpty():Boolean;

	/**
	 * 返回此映射中包含的键的 set 视图。
	 * @return
	 * @see Set
	 *
	 */
	function keySet():Set;

	/**
	 * 将指定的值与此映射中的指定键相关联
	 * @param key 键
	 * @param value 值
	 *
	 */
	function put(key:Object, value:Object):void

	/**
	 * 从指定映射中将所有映射关系复制到此映射中
	 * @param map
	 *
	 */
	function putAll(map:Map):void

	/**
	 * 返回此映射中的键-值映射关系数。
	 * @return
	 *
	 */
	function size():uint

	/**
	 * 返回此映射中包含的值的
	 * @return
	 *
	 */
	function getAllValue():Collection;

	/**
	 * 如果存在此键的映射关系，则将其从映射中移除.
	 * @param key 键
	 *
	 */
	function removeByKey(key:*):*;

}
}