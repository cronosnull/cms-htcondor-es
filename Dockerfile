FROM cern/cc7-base
ADD . /cms-htcondor-es
RUN yum install -y git python36-virtualenv
RUN virtualenv-3 -p python36 /cms-htcondor-es/venv
RUN source /cms-htcondor-es/venv/bin/activate && pip install -r /cms-htcondor-es/requirements.txt

RUN echo -e '\
[elastic-7.x]\n\
name=Elastic repository for 7.x packages\n\
baseurl=https://artifacts.elastic.co/packages/7.x/yum\n\
gpgcheck=1\n\
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch\n\
enabled=1\n\
autorefresh=1\n\
type=rpm-md'> /etc/yum.repos.d/elastic.repo && yum --enablerepo=elastic-7.x install -y filebeat && systemctl enable filebeat


