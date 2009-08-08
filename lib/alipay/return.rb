require 'alipay/sign'
 
module Alipay
  class Return
    include Sign

    attr_accessor :params

    def initialize(query_string)
         @params = parse(query_string)
    end

    def parse(query_string)
        return {} if query_string.blank?

        query_string.split('&').inject({}) do |memo, chunk|
            next if chunk.empty?
            key, value = chunk.split('=', 2)
            next if key.empty?
            value = value.nil? ? nil : CGI.unescape(value)
            memo[CGI.unescape(key)] = value
            memo
        end
    end


    def order
      @params["out_trade_no"]
    end

    def amount
      @params["total_fee"]
    end


    def success?
      unless verify_sign
        @message = "Alipay Error: ILLEGAL_SIGN"
        return false
      end

      true
    end

    def message
      @message
    end

  end
end