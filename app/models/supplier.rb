class Supplier < ApplicationRecord
  has_many :items, dependent: :destroy

  def self.search(params)
    query = self.all
    query = query.where('name LIKE ?', "%#{params[:name]}%") if params[:name].present?
    query
  end

  def self.supplier_by_category
    select('distinct(suppliers.id), suppliers.name, categories.id as category_id, suppliers.logo')
    .joins(items: :category)
  end
end
