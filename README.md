# **SSM**

> 说明：本项目是网易云课堂上基于SSM(Spring+SpringMVC+MyBatis)的实战项目，代码是本人跟着教学视频敲出来的。

1.本项目前端框架使用BootStrap和JQuery，在引入框架时应先引入JQuery，再引入BootStrap，否则BootStrap会报错。  

2.本项目的实体类，即包com/pan/ssm/bean里的bean和对应的Mapper配置文件及Mapper类使用MyBatis Generator自动生成，生成的Mapper配置文件位于src/main/resources/mapper文件夹下，生成的Mapper类位于com/pan/ssm/dao包里。用于生成这些文件的XML配置文件位于/SSM/mbg.xml。  

3.本项目使用Maven管理项目的包依赖，所有的包依赖写在pom.xml文件中。