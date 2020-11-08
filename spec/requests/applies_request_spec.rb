require 'rails_helper'

RSpec.describe "Applies", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/applies/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/applies/destroy"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/applies/index"
      expect(response).to have_http_status(:success)
    end
  end
end
