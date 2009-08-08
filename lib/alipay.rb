require  'alipay/helper'
require  'alipay/notification'
require  'alipay/return'


module Alipay
  ACCOUNT = "xxxx"
  KEY = "xxxx"
  SERVICE_URL = "https://www.alipay.com/cooperate/gateway.do"
  PAY_EMAIL = "xxx@xxx.com"

  def self.notification(post)
    Notification.new(post)
  end

  def self.return(query_string)
    Return.new(query_string)
  end

end