require 'rails_helper'

RSpec.describe DnsController, type: :controller do

  let(:valid_attributes) {
    { ip: "1.1.1.1", domains: ["lorem.com", "ipsum.com", "dolor.com", "amet.com"] }
  }

  let(:invalid_attributes) {
    { ips: "", domains: "fast.com, ruby.net" }
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    before do
      Dns.create! valid_attributes
      Dns.create!(ip: "2.2.2.2", domains: ["ipsum.com"])
      Dns.create!(ip: "3.3.3.3", domains: ["ipsum.com", "dolor.com", "amet.com"])
      Dns.create!(ip: "4.4.4.4", domains: ["ipsum.com", "dolor.com", "sit.com", "amet.com"])
      Dns.create!(ip: "5.5.5.5", domains: ["dolor.com", "sit.com"])
    end

    it "returns a success response" do
      get :index, params: { page: 1 }
      expect(response).to be_successful
    end

    it "requires the page parameter" do
      expect{ get(:index, params: {}) }.to raise_error ActionController::ParameterMissing
    end

    it "accepts filters" do
      params = {
        page: 1,
        include: ["ipsum.com", "dolor.com"],
        exclude: ["sit.com"]
      }

      get :index, params: params
      json_response = JSON.parse(response.body)
      expect(json_response["domains"].size).to eq(2)
      expect(json_response["domains"].first["ip"]).to eq("1.1.1.1")
      expect(json_response["domains"].last["ip"]).to eq("3.3.3.3")
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      dns = Dns.create! valid_attributes
      get :show, params: {id: dns.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Dns" do
        expect {
          post :create, params: {dns: valid_attributes}
        }.to change(Dns, :count).by(1)
      end

      it "renders a JSON response with the new dns" do
        post :create, params: {dns: valid_attributes}
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(dn_url(Dns.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new dns" do

        post :create, params: {dns: invalid_attributes}

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    let(:dns) { Dns.create!(valid_attributes) }

    context "with valid params" do
      let(:new_attributes) {
        { ip: "2.2.2.2", domains: ["new.com"] }
      }

      it "updates the requested dns" do
        put :update, params: {id: dns.to_param, dns: new_attributes}
        dns.reload
        expect(dns.ip).to eq(new_attributes[:ip])
        expect(dns.domains).to eq(new_attributes[:domains])
      end

      it "renders a JSON response with the dns" do
        put :update, params: {id: dns.to_param, dns: valid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new dns" do
        allow_any_instance_of(Dns).to receive(:update).and_return(false)
        put :update, params: {id: dns.to_param, dns: invalid_attributes}

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested dns" do
      dns = Dns.create! valid_attributes
      expect {
        delete :destroy, params: {id: dns.to_param}
      }.to change(Dns, :count).by(-1)
    end
  end

end
