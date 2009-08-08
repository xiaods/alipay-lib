class Order < ActiveRecord::Base
  belongs_to :pay_type
  
  # 保存定单前生成定单号
  def before_create
    self.order_code = generate_code
  end

  
  private
  def generate_code
    Time.now.strftime("%Y%m%d%H%M") + ("%04d" % rand(10000))
  end
  
end
