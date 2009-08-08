module OnlinePayResult
  include Alipay


  def online_pay_result
    case params[:id]
    when "alipay"
      result = Alipay::Return.new(request.query_string)
    when "tenpay"
      result = Tenpay::Return.new(request.query_string)
    else
      flash[:notice] = "支付失败!"
      return false
    end

    if result.success?
      Order.pay!(result.order, result.amount)
      flash[:notice] = "支付成功!"
    else
      logger.info request.query_string
      logger.warn result.message
      flash[:notice] = "支付失败!"
    end
  end

  def notify_result
    if params[:id] == "alipay"
      notification = Alipay::Notification.new(request.raw_post)
      if notification.complete? && Order.pay!(notification.order, notification.amount)
        logger.info "notify success"
        render :text => "success"
      else
        logger.info request.raw_post
        logger.warn notification.message
        render :text => "fail"
      end
    else
      raise
    end
  end
end