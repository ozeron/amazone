require 'rails_helper'

describe CreateProductService do
  let(:user) { create(:user) }
  subject { CreateProductService.new({}, user) }
  before do
    allow(subject).to receive(:asin) { asin }
  end

  context 'valid ASIN' do
    let(:asin) { 'B00OQVZDJM' }
    let(:result) do
      {
        title: "Kindle Paperwhite E-reader - Black, 6\" High-Resolution Display (300 ppi) with Built-in Light, Wi-Fi - Includes Special Offers",
        manufacturer: "Amazon"
      }
    end

    before do
      allow(subject).to receive(:load_metadata) { result }
    end

    it 'save Product to DB' do
      expect { subject.perform! }.to change { Product.count }.by(1)
    end

    it 'succeed' do
      subject.perform!
      expect(subject.succeed?).to be true
    end
  end
  context 'invalid ASIN' do
    let(:asin) { 'B00OQ' }
    let(:result) { {} }

    before do
      allow(subject).to receive(:load_metadata) { result }
    end

    it 'failed' do
      subject.perform!
      expect(subject.failed?).to be true
    end

    it 'errors' do
      subject.perform!
      expect(subject.errors).to_not be_empty
    end
  end
end
