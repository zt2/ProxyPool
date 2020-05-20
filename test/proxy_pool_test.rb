# frozen_string_literal: true

require 'test_helper'

class ProxyPoolTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ProxyPool::VERSION
  end

  def test_proxy_get
    refute_nil ::ProxyPool.get
  end

  def test_proxy_get_with_block
    refute_nil ::ProxyPool.get { |proxy| proxy['type'] == 'http' }
  end

  def test_get_high_anonymous_proxy
    proxy = ::ProxyPool.get_high_anonymous_proxy
    assert_equal 'high_anonymous', proxy['anonymity']
  end

  def test_get_by_country
    proxy = ::ProxyPool.get_by_country('us')
    assert_equal 'US', proxy['country']
  end

  def test_get_http_proxy
    proxy = ::ProxyPool.get_http_proxy
    assert_equal 'http', proxy['type']
  end

  def test_get_https_proxy
    proxy = ::ProxyPool.get_https_proxy
    assert_equal 'https', proxy['type']
  end

  def test_remove_proxy_from_pool
    proxy = ::ProxyPool.get
    assert_equal true, ::ProxyPool::Dealer.instance.pools.include?(proxy)
    ::ProxyPool.remove(proxy)
    assert_equal false, ::ProxyPool::Dealer.instance.pools.include?(proxy)
  end
end
