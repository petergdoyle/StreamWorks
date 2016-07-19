
FROM streamworks/base

RUN yum -y install epel-release gcc gcc-c++
RUN yum -y install node npm

# install node packages
RUN npm install format-json-stream express express-generator forever -g

CMD /bin/bash
