require 'shodan'
require 'yaml'
require 'pp'

# Verify we have correct arguments
unless ARGV.count.equal? 1
  pp '1 argument required!'
  pp 'Please include your scanhub yml file'
  pp 'See README for info'
  exit
end

# verify yml file is correct
begin
  config = YAML.load_file(ARGV[0])
  scan_key = config['scan_key']
  search_type = config['search_type']
  query = config['query']

  if scan_key.nil?
    pp "[ERROR] scan_key not found in #{ARGV[0]}"
    exit
  elsif search_type.nil?
    pp "[ERROR] search_type not found in #{ARGV[0]}"
    exit
  elsif query.nil?
    pp "[ERROR] query not found in #{ARGV[0]}"
    exit
  end
rescue => e
  pp "[ERROR] Could not load #{ARGV[1]} yml file"
  pp e
  exit
end

# do the query
api = Shodan::WebAPI.new(scan_key)
#api = Shodan::Shodan.new(scan_key)

begin
  results = api.host(query) if search_type.eql? 'host'
  results = api.search(query) if search_type.eql? 'search'
  pp "Found: #{results.count} results"
  pp results
rescue => e
  pp "ERROR"
  pp e
end
