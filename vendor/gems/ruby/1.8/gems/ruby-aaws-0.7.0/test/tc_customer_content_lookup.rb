# $Id: tc_customer_content_lookup.rb,v 1.1 2009/06/02 00:29:18 ianmacd Exp $
#

require 'test/unit'
require './setup'

class TestCustomerContentLookup < AWSTest

  def test_customer_content_lookup

    @req.locale = 'us'
    ccl = CustomerContentLookup.new( 'AJDWXANG1SYZP' )
    rg = ResponseGroup.new( :CustomerReviews )

    response = @req.search( ccl, rg )

    review = response.customer_content_lookup_response.customers.customer.
	     customer_reviews.review[0]

    # Ensure we got the right review.
    #
    assert_equal( 3746, review.content[0].size )

  end

  def test_customer_content_lookup_no_response_group

    @req.locale = 'us'
    ccl = CustomerContentLookup.new( 'AJDWXANG1SYZP' )
    ccl.response_group = ResponseGroup.new( :CustomerReviews )
    response = @req.search( ccl, nil )

    review = response.customer_content_lookup_response.customers.customer.
	     customer_reviews.review[0]

    # Ensure we got the right review.
    #
    assert_equal( 3746, review.content[0].size )

  end

  def test_customer_content_lookup_class_method

    response = Amazon::AWS.customer_content_lookup( 'AA5QZU6TJQXEN' )

    nickname = response.customer_content_lookup_response.customers.customer.
	       nickname

    assert_equal( 'jimwood43', nickname )

  end

  def test_item_search_class_method_block

    Amazon::AWS.customer_content_lookup( 'AA5QZU6TJQXEN' ) do |r|

      nickname = r.customer_content_lookup_response.customers.customer.nickname

      assert_equal( 'jimwood43', nickname )

    end
  end

end
