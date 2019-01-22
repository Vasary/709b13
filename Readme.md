
# Mail server  
  
Simple mail server for easiest mailing.
  
## Getting Started  
```  
# mkdir -p /data/docker/mailer/application  
# git clone git@github.com:Vasary/709b13.git /data/docker/mailer/application  
```  
  
## Fix settings  
  
#### Users and aliases  
Add necessary user data with regexp rules. Each set of parameters with the new line.

**Notice: The whitespaces are delimiter for parameters.**

> *Example:*  * notification			 1234567890		/^(.+)@domain.com$/i*  
> Explanation: user						password			expression
```  
# cp ./var/users.dist ./var/users  
# vi ./var/users  
```  
  
#### Domain config  
Set your domain in environment file.
```  
# cp ./env/.env.dist ./var/.env  
# vi ./.env  
```  
  
## Starting  
```  
# cd /data/docker/mailer/application  
# sudo make build  
# sudo make start  
```  
  
## Ports  
* 25  
* 110  
* 143  
  
## License  
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details