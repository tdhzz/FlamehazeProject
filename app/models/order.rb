class Order < ApplicationRecord

  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :address_id, presence: true
  validates :total_money, presence: true
  validates :amount, presence: true
  validates :order_no, uniqueness: true

  belongs_to :user
  belongs_to :product
  belongs_to :address
  belongs_to :payment

  before_create :gen_order_no

  module OrderStatus
    Initial = 'initial'
    Paid = 'paid'
    Send = 'send'
    Finish = 'finish'
  end

  def is_paid?
    self.status == OrderStatus::Paid
  end

  def is_initial?
    self.status == OrderStatus::Initial
  end

  def is_send?
    self.status == OrderStatus::Send
  end

  def is_finish?
    self.status == OrderStatus::Finish
  end

  def self.create_order_from_shopping_carts! user, address, *shopping_carts
    shopping_carts.flatten!
    address_attrs = address.attributes.except!("id", "created_at", "updated_at")

    orders = []

    transaction do
      order_address = user.addresses.create!(address_attrs.merge(
        "address_type" => Address::AddressType::Order
      ))

      shopping_carts.each do |shopping_cart|
        orders << user.orders.create!(
          product: shopping_cart.product,
          address: order_address,
          amount: shopping_cart.amount,
          total_money: shopping_cart.amount * shopping_cart.product.price
        )
      end

      shopping_carts.map(&:destroy!)
    end

    orders
  end

  def do_success_send! options
    self.transaction do

      # 更新订单状态
      self.orders.each do |order|
        if order.is_send?
          raise "order #{order.order_no} has alreay been send"
        end

        order.status = Order::OrderStatus::Send
        order.payment_at = Time.now
        order.save!
      end
    end
  end

  def do_success_finish! options
    self.transaction do

      # 更新订单状态
      self.orders.each do |order|
        if order.is_finish?
          raise "order #{order.order_no} has alreay been finish"
        end

        order.status = Order::OrderStatus::Finish
        order.payment_at = Time.now
        order.save!
      end
    end
  end

  private
  def gen_order_no
    self.order_no = RandomCode.generate_order_number
  end

end
