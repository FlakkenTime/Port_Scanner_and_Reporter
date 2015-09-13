# Port_Scanner_and_Reporter
This uses massscan to scan an ip range and then uploads the results
to scanhub. The main part of this is scan_and_report.rb. This will cover
the massscan and upload. I've included a second file shodan_lookups.rb
that can be used for requesting the scanhub api. See below for more details.

# Requiremens
1. massscan is installed. You can clone it form here and build it yourself:
https://github.com/robertdavidgraham/masscan

2. You have a scanhub.shodan.io account

# massscan configuration file
This should be in the format as described on the massscan github page:
https://github.com/robertdavidgraham/masscan

Example:
```
rate = 10000
output-format = xml
output-filename = scan.xml
ports = 0-100
range = 127.0.0.1/24
```

# scanhub configuration yml file
This information can be found scanhubs upload page. The info is used
to upload the scan results

Example scanhub.yml:
```
file_name: 'scan.xml'
scan_key: '1234567890AaBbCcDdEeFfGgHhIiJjKk'

# used in shodan_lookups
$ this can be `host` or `search`
search_type: 'search'
# if `host` this should be an ip, if search can be a protocol see shodan api for more
# http://www.shodanhq.com/help/filters
query: 'HTTP'
```

# How to run scan_and_report.rb
massscan requires access that may need root privileges. Here's how I run it:
`sudo ruby scan_and_report.rb ~/mass_commands ~/scanhub.yml`

# How to search results
Requires `shodan` gem be installed and the above scanhub.xml file.
`ruby shodan_lookups.rb  ~/scanhub.yml`

Example 1. With `search_type: 'search'` and `query: 'HTTP'`. If you run the above command
you will get all results where a port response included an http header.

Example 2. With `search_type: 'host'` and `query: '127.0.0.1'`. If you run the above command
you will get all info related to this host.
