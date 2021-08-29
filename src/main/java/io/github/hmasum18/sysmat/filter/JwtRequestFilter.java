package io.github.hmasum18.sysmat.filter;

import io.github.hmasum18.sysmat.service.MyUserDetailsService;
import io.github.hmasum18.sysmat.util.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.Optional;

@Component
public class JwtRequestFilter extends OncePerRequestFilter{
    public static final String TAG = "JwtRequestFilter->";

    @Autowired
    MyUserDetailsService userDetailsService; //to get the user info by username or id

    @Autowired
    JwtUtil jwtUtil; //to purse the jwt token from the cookie

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response
            , FilterChain filterChain) throws ServletException, IOException {
        String funcName = "doFilterInternal(): ";

        System.out.println(TAG + "doFilterInternal: "+ request.getMethod() +":"+ request.getRequestURI());
        Optional<String> jwtToken = this.readServletCookie(request, "jwt_token");

        String authenticationMsg = TAG+ (SecurityContextHolder.getContext().getAuthentication() != null?
                "found authentication in the context":  "auth is null");
        System.out.println(authenticationMsg);

         if(request.getRequestURI().equals("/auth/login") && request.getMethod().equalsIgnoreCase("post")){
            System.out.println(TAG + funcName + "login new user");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            System.out.println(TAG  + funcName  + " username: " + username);
            if(userDetailsService.validateUserCredential(username, password)){
                this.setAuthentication(username,null, request, response);
            }else{
                System.out.println(TAG + funcName +" invalid username or password.");
            }
        }else if (jwtToken.isPresent()) {
             System.out.println(TAG  + funcName  + "found jwt token in cookies");
             String jwt = jwtToken.get();
             String username = jwtUtil.extractUsername(jwt);
             this.setAuthentication(username,jwt, request, response);
         }

        // continue default filter chain
        filterChain.doFilter(request, response);
    }

    private void setAuthentication(String username, String jwt, HttpServletRequest request,
                                   HttpServletResponse response){
        String funcName = "setAuthentication(): ";
        try {
            UserDetails userDetails = userDetailsService.loadUserByUsername(username);
            if (userDetails != null && SecurityContextHolder.getContext().getAuthentication() == null) {
                // user is logging in
                if(jwt == null){
                    jwt = jwtUtil.generateToken(userDetails);
                    this.saveJwtTokenInCookie(response, jwt);
                    System.out.println(TAG + funcName + " new jwt token saved in the cookie.");
                }
                if(jwtUtil.validateToken(jwt, userDetails)) {
                    UsernamePasswordAuthenticationToken springAuthToken
                            = new UsernamePasswordAuthenticationToken(
                            userDetails, null, userDetails.getAuthorities());

                    springAuthToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                    SecurityContextHolder.getContext().setAuthentication(springAuthToken);
                    System.out.println(TAG+ funcName +" authentication updated.");
                }
            }
        }catch (UsernameNotFoundException e) {
            System.out.println(TAG+ funcName +username+" not found in the database.");
        }catch (Exception e){
            System.out.println(TAG+ funcName +" Exception while setting authentication.");
            e.printStackTrace();
        }
    }

    private Optional<String> readServletCookie(HttpServletRequest request, String name) {
        if(request.getCookies() == null)
            return Optional.empty();
        return Arrays.stream(request.getCookies())
                .filter(cookie -> name.equals(cookie.getName()))
                .map(Cookie::getValue)
                .findAny();
    }

    private void saveJwtTokenInCookie(HttpServletResponse response, String jwt) {
        //make cookie
        //https://dzone.com/articles/how-to-use-cookies-in-spring-boot
        Cookie cookie = new Cookie("jwt_token", jwt);
        cookie.setMaxAge(24 * 24 * 3600); //24 days validity
        cookie.setSecure(true);
        cookie.setHttpOnly(true);
        cookie.setPath("/");
        response.addCookie(cookie);
    }
}

