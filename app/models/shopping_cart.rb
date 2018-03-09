class ShoppingCart < ApplicationRecord

  validates :user_number, presence: true
  validates :product_id, presence: true
  validates :amount, presence: true

  belongs_to :product

  scope :by_user_number, -> (user_number) { where(user_number: user_number) }

  def self.create_or_update! options = {}
    condition = {
      user_number: options[:user_number],
      product_id: options[:product_id]
    }

    record = where(condition).first
    if record
      record.update_attributes!(options.merge(amount: record.amount + options[:amount]))
    else
      record = create!(options)
    end
    record
  end

end
