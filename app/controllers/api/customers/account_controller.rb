module Api
  module Customers
    class AccountController < ActionController::Base
      include ErrorResponseGenerateable
      skip_before_action :verify_authenticity_token

      def register
        @customer = Customer.new(request_params)
        ActiveRecord::Base.transaction do
          if @customer.save
            @token = PasswordSetting.new(customer_id: @customer.id)
            @token.save
          else
            return error_422(@customer.errors.full_messages)
          end
        end
        url = "#{request.base_url}/customer/password_setting/#{@token.token}"
        begin
          ::CustomerMailer.send_mail_verify_login_id(@customer.id, url).deliver_later
        rescue StandardError => e
          Rails.logger.info("send mail false customer_id: #{@customer.id}")
        end
      end

      def active_account
        @password_setting = PasswordSetting.find_by(token: params[:token])
        if @password_setting.nil? || @password_setting.password_setup_token_expired?
          return render json: { status: 'NG', message: 'not_found' }, status: :ok
        end

        @customer = @password_setting.customer.update(status: :active)
        @password_setting.delete
        render json: { status: 'ok', messages: 'ok' }, status: :ok
      end

      def forgot_password
        customer = Customer.find_by(email: params[:email], status: [:not_yet_authenticated, :active])
        return error_422('Email không tồn tại.') if customer.nil?

        @password_reset = customer.password_reset.new
        @password_reset.save

        begin
          ::CustomerMailer.send_mail_forgot_password(customer, @password_reset.token).deliver_later
        rescue StandardError => e
          Rails.logger.info("send mail false customer_id: #{customer.id}")
        end
      end

      def reset_password
        @customer = Customer.find_by(email: params[:email], status: [:not_yet_authenticated, :active])
        return error_422('Email không tồn tại.') if @customer.nil?

        password_reset = PasswordReset.find_by(token: params[:token])
        if password_reset.nil? || password_reset.password_reset_token_expired?
          return render json: { status: 'NG', message: 'not_found' }, status: :ok
        end

        @customer.update(password: params[:password], status: :active)
        password_reset.delete
      end

      private

      def request_params
        params.permit(
          :name,
          :email,
          :phone,
          :password,
        )
      end
    end
  end
end
