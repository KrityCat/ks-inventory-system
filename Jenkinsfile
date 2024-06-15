pipeline{
    agent any
    environment {
      IMAGE_NAME = "ruoyi-admin"
      WS = "${WORKSPACE}"
    }

    //定义流水线的加工流程
    stages {
        //流水线的所有阶段
        stage('1.环境检查'){
            steps {
               sh 'pwd && ls -alh'
               sh 'printenv'
               sh 'docker --version'
               sh 'java --version'
               sh 'git --version'
            }
        }

        stage('2.编译'){
            agent {
                docker {
                    image 'maven:3-alpine'
                    args '-v maven-repository:/root/.m2'
                }

            }
            steps {
                sh 'pwd && ls -alh'
                sh 'mvn -v'
                sh 'cd ${WS} && mvn clean package -s "/var/jenkins_home/appconfig/maven/settings.xml" -Dmaven.test.skip=true'
                // sh 'mvn -B -DskipTests clean package'
            }
        }

        stage('3.打包'){
            steps {
               sh 'pwd && ls -alh'
               sh 'echo ${WS}'
               sh 'docker build -t ${IMAGE_NAME} -f Dockerfile ${WS}/${IMAGE_NAME}/target/'
            }
        }

        stage('4.部署'){
            // 删除容器和虚拟镜像
            steps {
               sh 'pwd && ls -alh'
               sh 'docker rm -f ${IMAGE_NAME} || true && docker rmi $(docker images -q -f dangling=true) || true'
               sh 'docker run -d -p 8035:8035 --name ${IMAGE_NAME} -v /mydata/logs/${IMAGE_NAME}:/logs/${IMAGE_NAME} ${IMAGE_NAME}'
            }
        }
    }

    // 清理工作空间
    // post {
    //     always {
    //         cleanWs()
    //     }
    // }
}