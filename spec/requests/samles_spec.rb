require 'rails_helper'

RSpec.describe "Samles", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/samles/index"
      expect(response).to have_http_status(:success)
    end
  end

end
