class Public::SessionsController < Devise::SessionsController

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :customer_state, only: [:create]



  def after_sign_in_path_for(resource)
    customer_path(current_customer)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up)
  end

  def customer_state
    ## 【処理内容1】 入力されたemailからアカウントを1件取得
    @customer = Customer.find_by(email: params[:customer][:email])
    ## アカウントを取得できなかった場合、このメソッドを終了する
    return if !@customer
    ## 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    if @customer.valid_password?(params[:customer][:password]) && @customer.is_deleted == true
      ## 【処理内容3】処理内容2がtrueかつcustomerのis_deletedがtrueならサインアップ画面に遷移
      flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
      redirect_to new_customer_registration_path
    else
      flash[:notice] = "ログインに成功しました。"
    end
  end



end

