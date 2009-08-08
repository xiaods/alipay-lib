require 'net/http'
require 'alipay/sign'
 
module Alipay
  class Notification
    include Sign
    
    attr_accessor :params
    attr_accessor :raw
    
    def initialize(post, options = {})
       @options = options
       empty!
       parse(post)
    end
    
    def gross_cents
        (gross.to_f * 100.0).round
    end
    
    # reset the notification.
    def empty!
      @params = Hash.new
      @raw = ""
    end
    
    
    def complete?
        if status != "TRADE_FINISHED"
          return false
        end

        unless verify_sign
          @message = "Alipay Error: ILLEGAL_SIGN"
          return false
        end

      true
    end
    
    def order
      @params["out_trade_no"]
    end

    def amount
      @params["total_fee"]
    end

    def message
      @message
    end

    def item_id
      params['']
    end

    def transaction_id
      params['']
    end
    
    # When was this payment received by the client.
    def received_at
      params['']
    end

    def payer_email
      params['']
    end

    def receiver_email
      params['']
    end

    def security_key
      params['']
    end

    # the money amount we received in X.2 decimal.
    def gross
      params['']
    end

    # Was this a test transaction?
    def test?
      params[''] == 'test'
    end

    def status
      params['trade_status']
    end
    
    # Acknowledge the transaction to Alipay. This method has to be called after a new
    # apc arrives. Alipay will verify that all the information we received are correct and will return a
    # ok or a fail.
    #
    # Example:
    #
    # def ipn
    # notify = AlipayNotification.new(request.raw_post)
    #
    # if notify.acknowledge
    # ... process order ... if notify.complete?
    # else
    # ... log possible hacking attempt ...
    # end
    def acknowledge
      payload = raw

      uri = URI.parse(Alipay.notification_confirmation_url)

      request = Net::HTTP::Post.new(uri.path)

      request['Content-Length'] = "#{payload.size}"
      request['User-Agent'] = "Shopcat Agent -- http://www.beibeigan.com"
      request['Content-Type'] = "application/x-www-form-urlencoded"

      http = Net::HTTP.new(uri.host, uri.port)
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE unless @ssl_strict
      http.use_ssl = true

      response = http.request(request, payload)

      # Replace with the appropriate codes
      raise StandardError.new("Faulty Alipay result: #{response.body}") unless ["AUTHORISED", "DECLINED"].include?(response.body)
      response.body == "AUTHORISED"
    end
    
    private

    # Take the posted data and move the relevant data into a hash
    def parse(post)
      @raw = post
      for line in post.split('&')
        key, value = *line.scan( %r{^(\w+)\=(.*)$} ).flatten
        params[key] = value
      end
    end
    
 end
end
