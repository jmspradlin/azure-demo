#!/bin/sh
# install httpd
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
# Create custom page
echo '<html><head><style>h1 {text-align:center;} body {background-color:${color};}</style></head><body><h1>Hello ACME Corp on ${vmname}</h1><br><br><h1>Powered by</h1><br><center><img src="${logo}"></center></body></html>' > /var/www/html/index.html
systemctl restart httpd