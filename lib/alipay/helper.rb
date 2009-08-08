require 'cgi'
require 'digest/md5'
require 'rubygems'
require 'active_support'
 
module Alipay
  class Helper 
    attr_reader :fields
    cattr_accessor :mappings
    
    def initialize(order, account, options = {})
      # options.assert_valid_keys([:amount, :currency, :test])
      @fields = {}
      self.order = order
      self.account = account
      self.amount = options[:amount]
      self.currency = options[:currency]
    end
    
    def self.mapping(attribute, options = {})
      self.mappings ||= {}
      self.mappings[attribute] = options
    end
    
    def add_field(name, value)
      return if name.blank? || value.blank?
      @fields[name.to_s] = value.to_s
    end

    def add_fields(subkey, params = {})
      params.each do |k, v|
        field = mappings[subkey][k]
        add_field(field, v) unless field.blank?
      end
    end
    
    def billing_address(params = {})
        add_address(:billing_address, params)
      end
      
      def shipping_address(params = {})
        add_address(:shipping_address, params)
      end
      
      def form_fields
        @fields
      end

    def sign
      add_field('sign',
                Digest::MD5.hexdigest((@fields.sort.collect{|s|s[0]+"="+CGI.unescape(s[1])}).join("&")+KEY)
               )
      add_field('sign_type', 'MD5')
    end
    
    
    # Replace with the real mapping
    mapping :account, 'partner'
    mapping :amount, 'total_fee'

    mapping :order, 'out_trade_no'

    mapping :seller, :email => 'seller_email'

    mapping :notify_url, 'notify_url'
    mapping :return_url, 'return_url'
    mapping :show_url, 'show_url'
    mapping :description, 'body'

    mapping :charset, '_input_charset'
    mapping :service, 'service'
    mapping :payment_type, 'payment_type'
    mapping :subject, 'subject'
    
    
private

  def add_address(key, params)
      return if mappings[key].nil?

      code = lookup_country_code(params.delete(:country))
      add_field(mappings[key][:country], code)
      add_fields(key, params)
  end
  
  

  def method_missing(method_id, *args)
    method_id = method_id.to_s.gsub(/=$/, '').to_sym
    # Return and do nothing if the mapping was not found. This allows
    # For easy substitution of the different integrations
    return if mappings[method_id].nil?

    mapping = mappings[method_id]

    case mapping
    when Array
      mapping.each{ |field| add_field(field, args.last) }
    when Hash
      options = args.last.is_a?(Hash) ? args.pop : {}

      mapping.each{ |key, field| add_field(field, options[key]) }
    else
      if args.length > 0
        add_field(mapping, args.last)
      else
        @fields[mapping.to_s]
      end
    end
  end

 end
end
