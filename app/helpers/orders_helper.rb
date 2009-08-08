module OrdersHelper
  def online_pay_form(options={},&block)
    options.assert_valid_keys(:pay_type_id, :code, :amount)
    options[:content]= capture(&block) if block_given?

    rendered = render :partial => "/shared/online_pay/form_#{PayType.id2key(options.delete(:pay_type_id))}", :locals => options

    if block_given?
      concat(rendered)
    else
      rendered
    end
  end
  
  #组包发给alipay  
  def payment_service_for(order, account, options = {}, &proc)
    raise ArgumentError, "Missing block" unless block_given?

    concat(form_tag(Alipay::SERVICE_URL, options.delete(:html) || {}))
    result = "\n"
    
    service_class = Alipay.const_get('Helper')
    @service = service_class.new(order, account, options)
    proc.call @service
    
    # yield service
    result << @service.form_fields.collect do |field, value|
      hidden_field_tag(field, value)
    end.join("\n")

    result << "\n"
    result << '</form>' 
    concat(result)
  end  
  
  
  def get_eq_options(obj)
    [["请选择", ""]] + obj.map {|o| [o.value, o.id] }
  end

end
