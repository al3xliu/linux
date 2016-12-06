### part of jenkins

#### pipeline
  how to build pipeline?the steps are as belows:
  * install pipeline build plugin
  * click "+" ,then select __build pipeline view__ option
  * choose what u need and create the view,by the way,u should choose a init job which u created before.
  now u can go through your pipeline view.
#### trigger job with parameter
  how to trigger jobs?the step are as belows:
  * install parameterized trigger plugin.
  * in init job,for example,add trigger parameterized build on other projects.
  * fill in __projects to build__
  * click add parameters,as
  ```
    PACKAGE_NAME=latest
    PROJ_DIR=/opt/projects
  ```
  * in next job,select __This project is parameterized__ in the general part of the config view.
  * fill in paramters' names.
