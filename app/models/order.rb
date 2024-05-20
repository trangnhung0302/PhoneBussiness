class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_one :review, dependent: :destroy
  belongs_to :customer
  belongs_to :customer_destination
  belongs_to :payment_type
  belongs_to :staff, optional: true
  belongs_to :order_cancel_reason, optional: true

  accepts_nested_attributes_for :order_items, allow_destroy: true

  before_create :set_initial_data

  enumerize :payment_status, in: {  unpaid: 10, wait_confirm: 20, paid: 30 }, scope: true
  enumerize :status, in: {  wait_confirm: 10, prepare: 20, transporting: 30, complete: 40, cancel: 90 }, scope: true

  SEARCH_BY_MONTH = 'month'.freeze
  SEARCH_BY_YEAR = 'year'.freeze
  SEARCH_BY_RANGE = 'range'.freeze

  def set_initial_data
    self.order_number ||= loop do
      code = Utility.make_random_string(2, 2)
      break code if Order.where(order_number: code).blank?
    end
  end

  def self.search(params)
    query = self.all
    if (params[:key_search])
      query = query.joins(:customer)
      query = query.where("order_number LIKE ? OR customers.name LIKE ?", "%#{params[:key_search]}%", "%#{params[:key_search]}%")
    end
    query = query.where(payment_status: params[:payment_status]) if params[:payment_status].present?
    query = query.where(status: params[:status]) if params[:status].present?
    if (params[:month]) 
      date_start = Time.zone.parse("#{params[:month]}").beginning_of_month.utc.strftime('%Y-%m-%d %H:%M:%S')
      date_end = Time.zone.parse("#{params[:month]}").end_of_month.utc.strftime('%Y-%m-%d %H:%M:%S')

      query = query.where('DATE_FORMAT(orders.created_at, "%Y-%m-%d") BETWEEN ? AND ?', date_start, date_end)
    end
    query = query.order(created_at: :desc)
    query
  end

  def self.calculate_revenue(date_start, date_end)
    select(
      'count((orders.id)) as count,
      sum(order_items.quantity * (order_items.price - order_items.purchase_price)) as sum_total,
      sum(order_items.quantity * order_items.purchase_price) as sum_expense,
      sum(order_items.quantity * order_items.price) as sum_income
    ').from('orders')
      .joins('left join order_items ON order_items.order_id = orders.id')
      .where('DATE_FORMAT(orders.created_at, "%Y-%m-%d") BETWEEN ? AND ?
              AND orders.payment_status = 30
              AND orders.status = 40',
             date_start,
             date_end)
  end

  def self.count_category_order(date_start, date_end)
    query = select('c.name, c.id, sum(oi.quantity) as sum_item,
                    sum(oi.quantity * (oi.price - oi.purchase_price)) as sum_price,
                    sum(oi.quantity * oi.purchase_price) as sum_expense,
                    sum(oi.quantity * oi.price) as sum_income
                  ').from('orders as o')
    query = query.joins("INNER JOIN order_items as oi ON oi.order_id = o.id")
    query = query.joins('INNER JOIN items as i ON oi.item_id = i.id')
    query = query.joins('RIGHT JOIN categories c ON i.category_id = c.id')
    query = query.where('DATE_FORMAT(o.created_at, "%Y-%m-%d") BETWEEN ? AND ?
                        AND o.payment_status = 30
                        AND o.status = 40',
                        date_start,
                        date_end)
    query.group('c.id').order('c.order')
  end

  def self.count_supplier_order(date_start, date_end)
    query = select('s.name, s.id, sum(oi.quantity) as sum_item,
                    sum(oi.quantity * (oi.price - oi.purchase_price)) as sum_price,
                    sum(oi.quantity * oi.purchase_price) as sum_expense,
                    sum(oi.quantity * oi.price) as sum_income
                  ').from('orders as o')
    query = query.joins("INNER JOIN order_items as oi ON oi.order_id = o.id")
    query = query.joins('INNER JOIN items as i ON oi.item_id = i.id')
    query = query.joins('RIGHT JOIN suppliers s ON i.supplier_id = s.id')
    query = query.where('DATE_FORMAT(o.created_at, "%Y-%m-%d") BETWEEN ? AND ?
                        AND o.payment_status = 30
                        AND o.status = 40',
                        date_start,
                        date_end)
    query.group('s.id').order('s.order')
  end
end
