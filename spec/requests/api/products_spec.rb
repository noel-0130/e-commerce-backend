require "rails_helper"

RSpec.describe "Products API", type: :request do
  describe "GET /api/products" do
    it "returns a list of products" do
      get "/api/products"

      expect(response).to have_http_status(:ok)
    end

    it "return products as JSON" do
      get "/api/products"

      expect(response.content_type).to include("application/json")
      expect(JSON.parse(response.body)).to be_an(Array)
    end

    it "return a single product" do
      product = Product.create!(
        name: "Test Keyboard",
        description: "Mechanical Keyboard",
        price: 2500,
        stock: 5
      )

      get "/api/products/#{product.id}"

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      expect(json["id"]).to eq(product.id)
      expect(json["name"]).to eq("Test Keyboard")
    end
  end

  describe "POST /api/products" do
    it "creates a new product" do
      product_params = {
        product: {
          name: "Test Mouse",
          description: "Gaming Mouse",
          price: 1499.50,
          stock: 10
        }
      }

      expect {
        post "/api/products", params: product_params
      }.to change(Product, :count).by(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe "PATCH /api/products/:id" do
    it "update an exisiting product" do
      product = Product.create!(
        name: "Test Mouse",
        price: 1000,
        stock: 5
      )
    
    patch "/api/products/#{product.id}", params: {
      product: {
        name: "Updated Mouse",
        price: 1500
      }
    }

    product.reload

    expect(response).to have_http_status(:ok)
    expect(product.name).to eq("Updated Mouse")
    expect(product.price).to eq(1500)
    expect(product.stock).to eq(5)
    end  
  end

  describe "DELETE /api/products/:id" do
    it "deletes an existing product" do
      product = Product.create!(
        name: "Test Mouse",
        price: 1500,
        stock: 5
      )

      expect {
        delete "/api/products/#{product.id}"
      }.to change(Product, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end


end