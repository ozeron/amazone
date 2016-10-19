require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  login_user

  describe '#index' do
    it 'be success' do
      get 'index'
      expect(response).to be_success
    end
  end
  describe '#new' do
    it 'be success' do
      get 'new'
      expect(response).to be_success
    end
  end

  describe '#create' do
    let(:asin) { 'B00OQVZDJM' }
    let(:valid_params) { { 'product' => { 'asin' => asin } } }
    let(:operation) { double('CreateProductService') }

    before do
      allow(CreateProductService).to receive(:prepare) { operation }
      allow(operation).to receive(:perform!)
    end

    context 'operation valid' do
      before do
        allow(operation).to receive(:succeed?) { true }
      end

      it 'set success flash' do
        post :create, valid_params
        expect(controller).to set_flash[:notice]
      end

      it 'redirect_to #index' do
        post :create, valid_params
        expect(subject).to redirect_to action: :index
      end
    end
    context 'asin invalid' do
      before do
        allow(operation).to receive(:succeed?) { false }
        allow(operation).to receive(:errors) { 'MyErrors' }
        allow(operation).to receive(:product) { double('Product') }
      end

      it 'set success flash' do
        post :create, valid_params
        expect(controller).to set_flash[:alert]
      end

      it 'redirect_to #index' do
        post :create, valid_params
        expect(subject).to render_template(:new)
      end
    end
  end
end
