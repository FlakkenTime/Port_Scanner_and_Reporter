require 'yaml'
require 'pp'

# Verify we have the correct arguments
unless ARGV.count.equal? 2
  pp '2 arguments required!'
  pp 'First your massscan configuration file'
  pp 'Second your scanhub yml file'
  pp 'See README for more info'
  exit
end

# Verify yml file has necessar parameters before we do the scan
begin
  config = YAML.load_file(ARGV[1])
  file_name = config['file_name']
  scan_key = config['scan_key']
  if file_name.nil? or scan_key.nil?
    pp "[ERROR] file_name not found in #{ARGV[1]} yml file" if file_name.nil?
    pp "[ERROR] scan_key not found in #{ARGV[1]} yml file" if scan_key.nil?
    exit
  end
rescue => e
  pp "[ERROR] Could not load #{ARGV[1]} yml file"
  pp e
  exit
end

# Execute massscan
cmd = "massscan -c #{ARGV[0]}"
cmd_resp = `#{cmd}`

unless cmd_resp.eql? 0 or cmd_resp.eql? ''
  pp '[ERROR] massscan returned error cannot continue'
  pp cmd_resp
  exit
end

# Upload the scan results
cmd = "curl -F nmap_xml=@#{file_name} \"https://scanhub.shodan.io/repository/upload/challenge-scan?key=#{scan_key}\""
cmd_resp = `#{cmd}`

unless cmd_resp.include? 'true'
  pp '[ERROR] failed to upload results'
  pp cmd_resp
  exit
end
