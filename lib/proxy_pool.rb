module ProxyPool
  #
  # Errors
  #

  # Base error
  class Error < StandardError;
  end

  require 'proxy_pool/version'
  require 'proxy_pool/dealer'

  class << self
    # Get anonymous proxy from pool randomly
    #
    # @param filter [Hash] Filter
    # @return [Hash] Proxy
    def get_anonymous_proxy(filter={})
      ProxyPool::Dealer.instance.get(true, filter)
    end

    # Get transparent proxy from pool randomly
    #
    # @param filter [Hash] Filter
    # @return [Hash] Proxy
    def get_transparent_proxy(filter={})
      ProxyPool::Dealer.instance.get(false, filter)
    end
  end

end
