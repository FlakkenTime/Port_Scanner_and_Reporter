# Port_Scanner_and_Reporter
This uses massscan to scan an ip range and then uploads the results to scanhub

# Requiremens
1. massscan is installed. You can clone it form here and build it yourself:
https://github.com/robertdavidgraham/masscan

2. You have a scanhub.shodan.io account

# massscan configuration file
This should be in the format as described on the massscan github page:
https://github.com/robertdavidgraham/masscan

Example:
rate = 10000
output-format = xml
output-filename = scan.xml
ports = 0-100
range = 127.0.0.1/24

# scanhub configuration file
This information can be found scanhubs upload page. The info is used to upload
the scan results

Example:
file_name = scan.xml
key = 1234567890AaBbCcDdEeFfGgHhIiJjKk
