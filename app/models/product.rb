class Product < ApplicationRecord

  validates :category_id, presence: { message: "类型不能为空" }
  validates :title, presence: { message: "名称不能为空" }
  validates :status, inclusion: { in: %w[true false],
    message: "商品状态必须为true | false" }
  validates :amount, presence: { message: "库存不能为空" }
  validates :amount, numericality: { only_integer: true,
    message: "库存必须为整数" },
    if: proc { |product| !product.amount.blank? }
  validates :msrp, presence: { message: "MSRP不能为空" }
  validates :msrp, numericality: { message: "MSRP必须为数字" },
    if: proc { |product| !product.msrp.blank? }
  validates :price, numericality: { message: "价格必须为数字" },
    if: proc { |product| !product.price.blank? }
  validates :price, presence: { message: "价格不能为空" }
  validates :description, presence: { message: "描述不能为空" }

  belongs_to :category
  has_many :product_images, -> { order(weight: 'desc') },
    dependent: :destroy
  has_one :main_product_image, -> { order(weight: 'desc') },
    class_name: :ProductImage

  has_many :comments

  before_create :set_default_attrs

  scope :onshelf, -> { where(status: Status::True) }

  module Status
    True = 'true'
    False = 'false'
  end

  private

  def set_default_attrs
    self.product_number = RandomCode.generate_product_number
  end

end
