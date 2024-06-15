package com.ruoyi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.mongo.MongoAutoConfiguration;

/**
 * 启动程序
 *
 * @author KrityCat
 */
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class, MongoAutoConfiguration.class}, scanBasePackages = {"org.jeecg.modules.jmreport", "com.ruoyi"})
public class RuoYiApplication {
    public static void main(String[] args) {
        SpringApplication.run(RuoYiApplication.class, args);
        System.out.println("w(ﾟДﾟ)w  铠思进销存系统启动成功  ヾ(≧▽≦*)o");
    }
}
