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
    # Update proxy pool
    #
    def update
      ProxyPool::Dealer.instance.update
    end

    # Get a proxy from proxy pool
    #
    # @return [Hash] Proxy
    def get(&block)
      ProxyPool::Dealer.instance.get(&block)
    end

    # Get high anonymous proxy
    #
    # @return [Hash] Proxy
    def get_high_anonymous_proxy
      get { |proxy| proxy['anonymity'] == 'high_anonymous' }
    end

    # Get proxy by country
    #
    # @param cn [String] Country code
    # @return [Hash] Proxy
    def get_by_country(cn)
      get { |proxy| proxy['country'].downcase == cn.downcase }
    end

    # Get http proxy
    #
    # @return [Hash] Proxy
    def get_http_proxy
      get { |proxy| proxy['type'] == 'http' }
    end

    # Get https proxy
    #
    # @return [Hash] Proxy
    def get_https_proxy
      get { |proxy| proxy['type'] == 'https' }
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
