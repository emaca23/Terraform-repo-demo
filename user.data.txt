#install Jenkins on EC2

#1# ensure software packages are up to date
sudo yum update –y

#2# add jenkins repo
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo

#3# import a key file from Jenkins to enable installation from the package
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade

#4# install Java
sudo dnf install java-17-amazon-corretto -y

#5# install Jenkins
sudo yum install jenkins -y

#6# enable jenkins service to start at boot
sudo systemctl enable jenkins

#7# start jenkins as a service
sudo systemctl start jenkins

