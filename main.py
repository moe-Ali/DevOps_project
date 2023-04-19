import subprocess
import requests
import re
import os

#to put your public ip in the security group ssh and be the only ip that can access it over ssh for better security
def get_public_ip():
    url = "https://checkip.amazonaws.com/"
    request = requests.get(url)
    ip = request.text
    
    with open('./terraform/main.tf', 'r') as file:
        lines = file.readlines()   
    for line_number,line in enumerate(lines):
        if "port 22" in line:
            lines[line_number]=re.sub("cidr_blocks =\[.*\]", 'cidr_blocks =["{}/32"]'.format(ip.strip()), lines[line_number])     
    with open('./terraform/main.tf', 'w') as file:
        file.writelines(lines)
          
def terraform_apply():
    print("\n!!Terraform Apply!!\n")
    get_public_ip()
    subprocess.run(["terraform", "init"],cwd="./terraform")
    subprocess.run(["terraform", "apply","-auto-approve"],cwd="./terraform")
      

def terraform_destroy():
    print("\n!!Terraform Destroy!!\n")
    subprocess.run(["terraform", "destroy","-auto-approve"],cwd="./terraform")
    open("./ansible/inventory", "w").close()

def shh_known_hosts():
    print("!!Putting the IP in the Known_hosts file!!")
    known_hosts_file = os.path.expanduser('~/.ssh/known_hosts') #Python doesn't understand the "~" from itself so we are giving it some help :)
    with open('./ansible/inventory', 'r') as file:
        lines = file.readlines()
    for line in lines:
        inventory_hostip=re.search("ansible_host=([0-9\.]*)",line)
        # Run the ssh-keyscan command to get the remote host key
        process = subprocess.Popen(['ssh-keyscan', inventory_hostip[1]], stdout=subprocess.PIPE)
        # Extract the host key from the process output
        host_key = process.communicate()[0]
        with open(known_hosts_file, 'a') as file:
            file.write(host_key.decode())
            
def ansible_start():
    print("\n!!Ansible Start!!\n")
    shh_known_hosts() # so we dont get asked yes/no to add the ip to known hosts
    subprocess.run(["ansible-playbook", "playbook.yaml", "-i","inventory"],cwd="./ansible")

def get_jenkins_passwod():
    with open('./ansible/inventory', 'r') as file:
        lines = file.readlines()
    for line in lines:
        if "jenkins_server" in line:
            jenkins_ip = re.search("ansible_host=([0-9\.]*)",line)
    print("Jenkins initialAdminPassword:")
    subprocess.run(["ssh","-i","devops_project.pem","ubuntu@{}".format(jenkins_ip[1]),"sudo","cat","/var/lib/jenkins/secrets/initialAdminPassword"],cwd="./keypair")

def get_nexus_passwod():
    with open('./ansible/inventory', 'r') as file:
        lines = file.readlines()
    for line in lines:
        if "nexus_server" in line:
            nexus_ip = re.search("ansible_host=([0-9\.]*)",line)
    print("Nexus admin password:")
    subprocess.run(["ssh","-i","devops_project.pem","ubuntu@{}".format(nexus_ip[1]),"sudo","cat","/opt/sonatype-work/nexus3/admin.password"],cwd="./keypair")

def get_server_ip():
    with open('./ansible/inventory', 'r') as file:
        lines = file.readlines()
    for line in lines:
        if "jenkins_server" in line:
            jenkins_ip = re.search("ansible_host=([0-9\.]*)",line)
        elif "nexus_server" in line:
            nexus_ip = re.search("ansible_host=([0-9\.]*)",line)
        elif "sonarqube_server" in line:
            sonar_ip = re.search("ansible_host=([0-9\.]*)",line)
    print("Jenkins server: {}:8080".format(jenkins_ip[1]),"Nexus server: {}:8081".format(nexus_ip[1]),"SonarQube server: {}:9000".format(sonar_ip[1]),sep=" ")
            
def main():
    print("Choose a number\nOptions:",
          """
        1) Terraform Apply
        2) Terraform Destroy
        3) Ansible Start
        4) start Project(Terraform Apply then Ansible Start and will output the Jenkins initialAdminPassword)
          """)
    picked_number=input("Your choise: ")
    
    if picked_number == "1":
        terraform_apply()
    elif picked_number == "2":
        terraform_destroy()
    elif picked_number == "3":
        ansible_start()
    elif picked_number == "4":
        terraform_apply()
        ansible_start()
        get_server_ip()
        get_jenkins_passwod()
        get_nexus_passwod()
    else:
        print("Please make sure to Enter on of this numbers [1,2,3,4]")
        main()
main()
