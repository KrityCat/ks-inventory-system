package com.ruoyi.common.core.domain.entity;


import java.util.List;

/**
 * 单据汇总对象 ServiceFrom
 *
 * @author KrityCat
 */
public class ServiceFrom extends HeadService {

    private List<DetailService> details;

    public List<DetailService> getDetails() {
        return details;
    }

    public void setDetails(List<DetailService> details) {
        this.details = details;
    }
}
