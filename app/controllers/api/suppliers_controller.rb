module Api
  class SuppliersController < Api::ApplicationController
    before_action :find_supplier, only: [:show]

    def index
      @suppliers = Supplier.supplier_by_category
    end

    def show
      
    end

    private

    def find_supplier
      @supplier = Supplier.find(params[:id])
      return error_404 if @supplier.nil?
    end
  end
end
