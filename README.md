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
NOTE: This returns world wide results currently. Despite spending the last hour
playing with this and looking online I can find no way to limit api requests
to your own scanhub scans. However using the website you can. This would
require a separate tool.

Requires `shodan` gem be installed and the above scanhub.xml file.
`ruby shodan_lookups.rb  ~/scanhub.yml`

Example 1. With `search_type: 'search'` and `query: 'HTTP'`. If you run the above command
you will get all results where a port response included an http header.

Example 2. With `search_type: 'host'` and `query: '127.0.0.1'`. If you run the above command
you will get all info related to this host.

# Ideas on how this could be used and improvements for later
1. Need to update the API to only request personal scanhub results as soon
as this is available.

2. Storing results in a small personal database in the form:
`host_ip`, `open_port1, open_port2, etc`
We could implement a daily checker that reports if anyi host has new ports
that have become active. This could be the sign of someone having access to
a system.

3. Can use the port searching in GUI (api later) to look for known protocols running
on unusual ports. During one world wide search I found a number of HTTP servers
on non standard ports such as port 1900. This may be a sign of someone running
an extra service on their system.. even if they don't know they're doing it.

4. For business scanning can also use port searching to verify no internal systems are
available externally. For example may search for ports such as 22 (SSH), 1434 (MS-SQL0),
3306 (MySQL), etc. These kinds of services should not be available to the
outside internet.
