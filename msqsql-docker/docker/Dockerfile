FROM microsoft/mssql-server-linux:latest

RUN apt-get update && apt-get install -y  \
	curl \
	apt-transport-https \
    unzip \
    sudo \
    cron \
    tzdata

#set timezone to Chicago
ENV TZ=Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata

# https://docs.microsoft.com/en-us/sql/connect/odbc/linux/installing-the-microsoft-odbc-driver-for-sql-server-on-linux
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get install -y locales && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

ENV PATH="/opt/mssql-tools/bin:${PATH}"

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && sudo ./aws/install 

# Set arguments for aws configure
ARG AWS_KEY='[AWS_KEY]'
ARG AWS_SECRET_KEY='[AWS_SECRET_KEY]'
ARG AWS_REGION='[AWS_REGION]' 

#run aws configure
RUN aws configure set aws_access_key_id $AWS_KEY && aws configure set aws_secret_access_key $AWS_SECRET_KEY && aws configure set default.region $AWS_REGION 

#Create a backup folder
RUN mkdir -p /var/opt/mssql/backup/
#Enter the newly created folder
WORKDIR /var/opt/mssql/backup

#Copy everything to the container
COPY . .

# Make the file executable
RUN chmod +x /var/opt/mssql/backup/init-setup.sh
#Run the bash file
RUN /var/opt/mssql/backup/init-setup.sh
