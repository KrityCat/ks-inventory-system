package com.ruoyi.common.utils;

import javax.servlet.http.HttpServletRequest;

/**
 * @author KrityCat
 */
public class TokenUtils {

    /**
     * 获取 request 里传递的 token
     *
     * @param request
     * @return
     */
    public static String getTokenByRequest(HttpServletRequest request) {
        String parameter = request.getParameter("token");
        String header = request.getHeader("token");
        if (parameter == null && header == null) {
            parameter = request.getHeader("Authorization");
        }
        return parameter != null ? parameter : header;
    }
}