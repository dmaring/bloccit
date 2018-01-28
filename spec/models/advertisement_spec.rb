require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  let(:advertisement) { Advertisement.create!(title: "New Ad Title", copy: "New Copy", price: 5 ) }

  describe "attributes" do
    it "has title, copy, and price attributes" do
      expect(advertisement).to have_attributes(title: "New Ad Title", copy: "New Copy", price: 5)
    end
  end

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "assigns [advertisement] to @advertisements" do
      get :index
      expect(assigns(:advertisements)).to eq([advertisement])
    end
  end

  describe "GET show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

end
