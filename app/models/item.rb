class Item < ApplicationRecord
  belongs_to :category
  belongs_to :supplier
  has_many :order_items
  has_many :carts
  has_many :item_images, dependent: :destroy
  has_many :item_colors, dependent: :destroy
  before_create :set_initial_data

  accepts_nested_attributes_for :item_images, allow_destroy: true
  accepts_nested_attributes_for :item_colors, allow_destroy: true

  enumerize :status, in: {  active: 10, out_of_stock: 20, stop_selling: 30 }, scope: true

  before_save :update_status

  def self.search(params)
    query = self.all
    query = query.where('name LIKE ?', "%#{params[:name]}%") if params[:name].present?
    query = query.where(category_id: params[:category_id]) if params[:category_id].present?
    query = query.where(supplier_id: params[:supplier_id]) if params[:supplier_id].present?
    query = query.where(status: params[:status]) if params[:status].present?
    query = query.where(status: params[:checked_status]) if params[:checked_status].present?
    query = query.order("price #{params[:sort_price]}") if params[:sort_price].present?
    query
  end

  def set_initial_data
    self.product_no ||= loop do
      code = Utility.make_random_string(2, 2)
      break code if Item.where(product_no: code).blank?
    end
  end

  def update_status
    if status != :stop_selling
      self.status = quantity > 0 ? :active : :out_of_stock
    end
  end
end
