class Category < ApplicationRecord
  has_many :items, dependent: :destroy

  def self.search(params)
    query = self.all
    query = query.where('name LIKE ?', "%#{params[:name]}%") if params[:name].present?
    query
  end
end
