require 'rails_helper'

RSpec.describe DnsController, type: :controller do

  let(:valid_attributes) {
    { ip: "1.1.1.1", domains: ["fast.com", "ruby.net"] }
  }

  let(:invalid_attributes) {
    { ips: "12345", domains: "fast.com, ruby.net" }
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      Dns.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
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
        puts valid_attributes.inspect
        expect {
          post :create, params: {dns: valid_attributes}
          puts response.body
        }.to change(Dns, :count).by(1)
      end

      it "renders a JSON response with the new dns" do
        post :create, params: {dns: valid_attributes}
        puts response.body.inspect
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(dn_url(Dns.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new dns" do

        post :create, params: {dns: invalid_attributes}, session: valid_session

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { ip: "2.2.2.2", domains: ["new.com"] }
      }

      it "updates the requested dns" do
        dns = Dns.create! valid_attributes
        put :update, params: {id: dns.to_param, dns: new_attributes}
        dns.reload
        expect(dns.ip).to eq(new_attributes[:ip])
        expect(dns.domains).to eq(new_attributes[:domains])
      end

      it "renders a JSON response with the dns" do
        dns = Dns.create! valid_attributes

        put :update, params: {id: dns.to_param, dns: valid_attributes}
        expect(response).to have_http_status(:ok)
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
