# frozen_string_literal: true

require 'test_helper'

class ProxyPoolTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ProxyPool::VERSION
  end

  def test_proxy_get
    refute_nil ::ProxyPool.get_anonymous_proxy
    refute_nil ::ProxyPool.get_transparent_proxy
  end

  def test_get_anonymous_proxy
    proxy = ::ProxyPool.get_anonymous_proxy
    assert_equal 'high_anonymous', proxy['anonymity']
  end

  def test_get_transparent_proxy
    proxy = ::ProxyPool.get_transparent_proxy
    refute_equal 'high_anonymous', proxy['anonymity']
  end

  def test_remove_proxy_from_pool
    proxy = ::ProxyPool.get_transparent_proxy
    assert_equal true, ::ProxyPool::Dealer.instance.transparent_pools.include?(proxy)
    ::ProxyPool.remove(proxy)
    assert_equal false, ::ProxyPool::Dealer.instance.transparent_pools.include?(proxy)

    proxy = ::ProxyPool.get_anonymous_proxy
    assert_equal true, ::ProxyPool::Dealer.instance.anonymous_pools.include?(proxy)
    ::ProxyPool.remove(proxy)
    assert_equal false, ::ProxyPool::Dealer.instance.anonymous_pools.include?(proxy)
  end
end
