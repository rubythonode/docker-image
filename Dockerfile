# Copyright 2017 Yahoo Holdings. Licensed under the terms of the Apache 2.0 license. See LICENSE in the project root.
FROM centos:7

RUN yum-config-manager --add-repo https://copr.fedorainfracloud.org/coprs/g/vespa/vespa/repo/epel-7/group_vespa-vespa-epel-7.repo && \
    yum -y install epel-release && \
    yum -y install centos-release-scl 

ADD include/start-container.sh /usr/local/bin/start-container.sh 

RUN yum install -y vespa-6.140.53

ENTRYPOINT ["/usr/local/bin/start-container.sh"]
