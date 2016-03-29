Puppet::Parser::Functions.newfunction(:get_dimensions, :type => :rvalue) do |args|
dimension_list = args[0]
aws_integration = args[1]
DIMENSIONS = "?"
if aws_integration
        puts "Getting AWS metadata..."
        uri = URI.parse("http://169.254.169.254/2014-11-05/dynamic/instance-identity/document")
        http = Net::HTTP.new(uri.host, uri.port)
        http.open_timeout = 4
        http.read_timeout = 4
        begin
                http.start
                begin
                        response = http.request(Net::HTTP::Get.new(uri.request_uri))
                rescue Timeout::Error
                       puts "ERROR: Unable to get AWS metadata, Timeout due to reading"
                end
        rescue Timeout::Error
                puts "ERROR: Unable to get AWS metadata, Timeout due to connecting"
        end
        unless response.nil? || response == 0
                result = JSON.parse(response.body)
                DIMENSIONS << "sfxdim_AWSUniqueId=#{result["instanceId"]}_#{result["region"]}_#{result["accountId"]}&"
        end
end
unless dimension_list.empty?
        dimension_list.each {|key, value| DIMENSIONS << "sfxdim_#{key}=#{value}&"}
end
DIMENSIONS[0...-1]
end
