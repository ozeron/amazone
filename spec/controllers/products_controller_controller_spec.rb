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
end
