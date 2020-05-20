# frozen_string_literal: true

module ProxyPool
  #
  # Errors
  #

  # Base error
  class Error < StandardError
  end

  require 'proxy_pool/version'
  require 'proxy_pool/dealer'

  class << self
    # Get anonymous proxy from pool randomly
    #
    # @param filter [Hash] Filter
    # @return [Hash] Proxy
    def get_anonymous_proxy(filter = {})
      ProxyPool::Dealer.instance.get(true, filter)
    end

    # Get transparent proxy from pool randomly
    #
    # @param filter [Hash] Filter
    # @return [Hash] Proxy
    def get_transparent_proxy(filter = {})
      ProxyPool::Dealer.instance.get(false, filter)
    end

    # Remove this proxy from pool
    #
    # @param proxy [Hash] Proxy
    # @return [nil]
    def remove(proxy)
      ProxyPool::Dealer.instance.remove(proxy)
    end
  end
end
