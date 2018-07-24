package com.zjg.admin.service;

import com.baomidou.mybatisplus.service.IService;
import com.zjg.admin.commons.result.PageInfo;
import com.zjg.admin.model.SysLog;

/**
 *
 * SysLog 表数据服务层接口
 *
 */
public interface ISysLogService extends IService<SysLog> {

    void selectDataGrid(PageInfo pageInfo);

}