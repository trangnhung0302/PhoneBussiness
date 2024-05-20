module Api
  module Staffs
    class SuppliersController < Staffs::ApplicationController
      before_action :find_supplier, only: [:update, :show]
      before_action :upload_image, if: -> { params[:image].present? }

      def index
        @pagy, @suppliers = pagy(Supplier.search(params))
      end
      
      def create
        @supplier = Supplier.new(request_params)
        @supplier.save!
      end

      def update
        @supplier.assign_attributes(request_params)
        @supplier.save!
      end

      def show
        
      end

      private

      def request_params
        request_params = params.permit(
          :name,
        )
        request_params = request_params.merge(logo: @image) if @image
        request_params
      end

      def find_supplier
        @supplier = Supplier.find(params[:id])
        return error_404 if @supplier.nil?
      end

      def upload_image
        require 'base64'
        data = Base64.decode64(params[:image][:content].to_s['data:image/png;base64,'.length..])

        if data.size > 3.megabytes
          error_422('写真が大きすぎます。')
        else
          folder_path = Rails.root.join('public', 'uploads', 'suppliers')
          FileUtils.mkdir_p(folder_path)

          File.open(File.join(folder_path, params[:image][:name]), 'wb') do |file|
            file.write(data)
          end
          @image = "/uploads/suppliers/#{params[:image][:name]}"
        end
      end
    end
  end
end
