package com.zjg.admin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.zjg.admin.mapper.SysDictItemMapper;
import com.zjg.admin.model.SysDictItem;
import com.zjg.admin.model.SysDictType;
import com.zjg.admin.model.User;
import com.zjg.admin.service.ISysDictItemService;
import com.zjg.admin.service.ISysDictTypeService;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author jianguo.zhao
 * @since 2018-07-21
 */
@Service
public class SysDictItemServiceImpl extends ServiceImpl<SysDictItemMapper, SysDictItem> implements ISysDictItemService {

	@Autowired
	private ISysDictTypeService sysDictTypeService;
	@Override
	public Map<String, Object> getMap() {
		Map<String, Object> dictCache = new HashMap<String, Object>();
			List<SysDictType> dictTypes = sysDictTypeService.selectList(null);
			SysDictItem queryParams = null;
			List<SysDictItem> dictItems = null;
			for(SysDictType type : dictTypes){
				queryParams = new SysDictItem();
				queryParams.setTypeCode(type.getTypeCode());
				EntityWrapper<SysDictItem> wrapper = new EntityWrapper<SysDictItem>(queryParams);
			    dictItems = super.selectList(wrapper);
				dictCache.put(type.getTypeCode(), dictItems);
			}
			return dictCache;
	}
	
}
