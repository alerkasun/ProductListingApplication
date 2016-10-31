require 'spec_helper'

describe Product do
  let(:product) { FactoryGirl.build :product }
  subject { product }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:price) }

  it { should validate_presence_of :name }
  it { should validate_length_of(:name).is_at_most(50) }
  it { should validate_presence_of :price }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(1) }
  it { should validate_numericality_of(:price).is_less_than_or_equal_to(1000000) }
  it { should validate_length_of(:description).is_at_most(400) }
  it { expect(Product).to respond_to :create! }

  it "return product object" do
    expect(Product.create! params).to be_a(Product)
  end

  it "change products counter" do
    expect{ Product.create! params }.to change{ Product.count }.by(1)
  end

  context "Bad arguments" do
    it "raise an exception ActiveRecord::RecordInvalid" do
      expect{ Product.create! name: FFaker::Internet.safe_email }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  def params
    { name: FFaker::Product.product_name, price: rand() * 100, description: FFaker::Lorem.paragraph }
  end
end
