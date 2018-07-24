package com.zjg.admin.service;

import java.util.Map;

import com.baomidou.mybatisplus.service.IService;
import com.zjg.admin.model.SysDictItem;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author jianguo.zhao
 * @since 2018-07-21
 */
public interface ISysDictItemService extends IService<SysDictItem> {
	
	public Map<String, Object> getMap();
}
