class Staff < ApplicationRecord
  has_secure_password

  has_many :order

  validates :email, :presence => true, :uniqueness => true

  def self.search(params)
    query = Staff.all
    query = query.where('name LIKE ?', "%#{params[:name]}%") if params[:name].present?
    query
  end
end
