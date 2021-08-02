package io.github.hmasum18.sysmat.config;

import io.github.hmasum18.sysmat.filter.SiteMeshFilter;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.nio.file.Path;
import java.nio.file.Paths;

@Configuration
public class WebConfiguration implements WebMvcConfigurer{
    public static final String IMAGE_UPLOAD_ROOT_PATH = "./uploaded-images";

    @Bean
    public FilterRegistrationBean siteMashFilter(){
        FilterRegistrationBean filterRegistrationBean = new FilterRegistrationBean();
        filterRegistrationBean.setFilter(new SiteMeshFilter());

        return filterRegistrationBean;
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        Path productLogoDir = Paths.get(IMAGE_UPLOAD_ROOT_PATH);

        String logoUploadAbsolutePath = productLogoDir.toFile().getAbsolutePath();
        registry.addResourceHandler("/uploaded-images/**")
                .addResourceLocations("file:/"+logoUploadAbsolutePath+"/");
    }
}
