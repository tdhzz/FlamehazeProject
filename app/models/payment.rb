class Payment < ApplicationRecord

  belongs_to :user
  has_many :orders

  before_create :gen_payment_no

  module PaymentStatus
    Initial = 'initial'
    Success = 'success'
    Failed = 'failed'
  end


  def do_success_payment! options
    self.transaction do
      self.transaction_no = options[:trade_no]
      self.status = Payment::PaymentStatus::Success
      self.raw_response = options.to_json
      self.payment_at = Time.now
      self.save!

      # 更新订单状态
      self.orders.each do |order|
        if order.is_paid?
          raise "order #{order.order_no} has alreay been paid"
        end

        order.status = Order::OrderStatus::Paid
        order.payment_at = Time.now
        order.save!
      end
    end
  end

  def do_failed_payment! options
    self.transaction_no = options[:trade_no]
    self.status = Payment::PaymentStatus::Failed
    self.raw_response = options.to_json
    self.payment_at = Time.now
    self.save!
  end


  def is_success?
    self.status == PaymentStatus::Success
  end

  def self.create_from_orders! user, *orders
    # 变成一维数组
    orders.flatten!

    payment = nil
    transaction do
      payment = user.payments.create!(
        total_money: orders.sum(&:total_money)
      )

      orders.each do |order|
        if order.is_paid?
          raise "order #{order.order_no} has already paid"
        end
        if order.is_send?
          raise "order #{order.order_no} has already send"
        end
        if order.is_finish?
          raise "order #{order.order_no} has already finish"
        end

        order.payment = payment
        order.save!
      end
    end

    payment
  end

  private

  def gen_payment_no
    self.payment_no = RandomCode.generate_utoken(32)
  end
end
