package com.utils;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginFilter implements Filter{
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override

    public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2)

            throws IOException, ServletException {

        // TODO Auto-generated method stub

        HttpServletRequest request = (HttpServletRequest)arg0;

        HttpServletResponse response = (HttpServletResponse)arg1;

        HttpSession session = request.getSession();



        if(session.getAttribute("username")==null

                && request.getRequestURI().indexOf("/system/login/signIn") == -1){

            // 没有登录

            response.sendRedirect(request.getContextPath()+"/system/login/signIn");

        }else{

            // 已经登录，继续请求下一级资源（继续访问）
            arg2.doFilter(arg0, arg1);

        }



    }

    @Override
    public void destroy() {

    }
}
