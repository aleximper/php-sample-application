# PHP 7.1 sample application

Sample PHP applications that uses:
* Dependency Injection
* Apache routing
* Composer (aka: Not reinventing the wheel)

## Requirements

* Unix-like operating systems
* Apache
* MariaDB/MySQL
* PHP >= 7.1
* Command line tools `make` & `wget`
* Docker y Docker compose

## Setup

1. Configure Apache file in etc folder:
```apache
<VirtualHost *:80>
    ServerName %application.host.name%
    DocumentRoot /%path-to-repository%/web

    <Directory /%path-to-repository%>
        Require all granted
        AllowOverride all
    </Directory>

    php_admin_value include_path "/%path-to-repository%/"

    Include /%path-to-repository%/config/vhost.conf
</VirtualHost>
```

You are all set, point your browser to http://%application.host.name%/

2. Execute the comand `docker-compose up`
3. test the app in http://localhost:8080
