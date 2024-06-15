FROM nginx:1.22

# 构建参数,在Jenkinsfile中构建镜像时定义
ARG PROFILE

# 将dist文件中的内容复制到 `/usr/share/nginx/html/` 这个目录下面
COPY dist/  /usr/share/nginx/html/

# 用本地配置文件来替换nginx镜像里的默认配置
# COPY nginx/nginx-${PROFILE}.conf /etc/nginx/nginx.conf
COPY nginx/nginx-${PROFILE}.conf /etc/nginx/nginx.conf

# 映射端口
EXPOSE 80

# 以前台形式持续运行
CMD ["nginx", "-g", "daemon off;"]