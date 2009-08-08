class PayType < ActiveRecord::Base
  OnlineKeys = [nil, :alipay,:tenpay]

  def self.id2key(id)
    OnlineKeys[id]
  end
end
