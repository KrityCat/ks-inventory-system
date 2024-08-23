package com.ruoyi.framework.web.service;

import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.TokenUtils;
import org.jeecg.modules.jmreport.api.JmReportTokenServiceI;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * @author KrityCat
 */
@Component
public class JimuReportTokenService implements JmReportTokenServiceI {

    @Autowired
    TokenService tokenService;

    @Override
    public String getUsername(String token) {
        LoginUser loginUser = tokenService.getLoginUserFromToken(token);
        return loginUser.getUsername();
    }

    @Override
    public String[] getRoles(String s) {
        return new String[0];
    }

    @Override
    public Boolean verifyToken(String token) {
        LoginUser loginUser = tokenService.getLoginUserFromToken(token);
        if (StringUtils.isNotNull(loginUser)) {
            tokenService.verifyToken(loginUser);
            return true;
        }
        return false;
    }

    @Override
    public String getToken(HttpServletRequest request) {
        return TokenUtils.getTokenByRequest(request);
    }

    @Override
    public Map<String, Object> getUserInfo(String token) {
        return null;
    }
}