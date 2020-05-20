# frozen_string_literal: true

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
    class HTTPError < Error
    end

    # Parse error
    class ParseError < Error
    end

    attr_reader :pools

    # Update to latest proxy list from fate0/proxylist
    #
    def update
      @pools = []

      res = HTTP.get 'https://raw.githubusercontent.com/fate0/proxylist/master/proxy.list'
      raise HTTPError, "invalid http code #{res.code}" if res.code != 200

      @updated_at = Time.now

      res.body.to_s.split("\n").each { |line| _pool_parse(line) }
    end

    # Get a random proxy
    #
    # @return [Hash] Proxy
    def get
      update if _need_update?

      target_pools = if block_given?
                       @pools.select { |proxy| yield proxy }
                     else
                       @pools
                     end
      target_pools.sample
    end

    # Remove this proxy from pool
    #
    # @param proxy [Hash] Proxy
    # @return [nil]
    def remove(proxy)
      @pools.delete(proxy)

      nil
    end

    private

    # Return true if we need to update proxy list
    #
    # @return [Boolean]
    def _need_update?
      return true if @updated_at.nil?

      # Re-update after 10 min
      delta = Time.now - @updated_at
      delta > 600
    end

    # Parse proxy list
    #
    # @param line [String]
    def _pool_parse(line)
      proxy = JSON.parse(line)
      unless proxy.key?('anonymity')
        raise ParseError, "no anonymity field: #{line}"
      end

      @pools << proxy
    rescue JSON::ParserError
      raise ParseError, "JSON parser error when parsing #{line}"
    end
  end
end
