# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper   
  
  
  
  #注入支付宝接口
  include  Alipay
  
  
  def online_pay_form(options={},&block)
    options.assert_valid_keys(:pay_type_id, :code, :user, :amount)
    options[:content]= capture(&block) if block_given?

    rendered = render :partial => "/shared/online_pay/form_#{PayType.id2key(options.delete(:pay_type_id))}", :locals => options

    if block_given?
      concat(rendered)
    else
      rendered
    end
  end
  
end
