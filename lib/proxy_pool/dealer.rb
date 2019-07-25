#
# Standard library
#
require 'json'
require 'singleton'

#
# Third-party library
#
require 'http'

module ProxyPool
  #
  # Pool
  #
  class Dealer
    include Singleton

    # HTTP error
    class HTTPError < Error;
    end

    # Parse error
    class ParseError < Error;
    end

    # Filter error
    class FilterError < Error;
    end

    attr_reader :transparent_pools, :anonymous_pools

    # Update to latest proxy list from fate0/proxylist
    #
    def update
      @transparent_pools = []
      @anonymous_pools = []

      res = HTTP.get 'https://raw.githubusercontent.com/fate0/proxylist/master/proxy.list'
      raise HTTPError, "invalid http code #{res.code}" if res.code != 200

      res.body.to_s.split("\n").each {|line| _pool_parse(line)}
    end

    # Get a random proxy
    #
    # @param anonymous [TrueClass | FalseClass] Return high anonymous proxy if true
    # @param filter [Hash] Filter
    # @return [Hash] Proxy
    def get(anonymous=true, filter={})
      update if @transparent_pools.nil? && @anonymous_pools.nil?

      target_pools = if anonymous
                       @anonymous_pools
                     else
                       @transparent_pools
                     end
      filter.each_pair { |k, v| target_pools = _pool_filter(target_pools, k.to_s, v) }

      target_pools.sample
    end

    private

    def _pool_parse(line)
      proxy = JSON.parse(line)
      raise ParseError, "no anonymity field: #{line}" unless proxy.key?('anonymity')

      case proxy['anonymity']
      when 'high_anonymous'
        @anonymous_pools << proxy
      else
        @transparent_pools << proxy
      end
    rescue JSON::ParserError
      raise ParseError, "JSON parser error when parsing #{line}"
    end

    def _pool_filter(proxy_pools, key, value)
      proxy_pools.select do |proxy|
        raise FilterError, "invalid filter: #{key}" unless proxy.key?(key)
        proxy[key] == value
      end
    end

  end
end