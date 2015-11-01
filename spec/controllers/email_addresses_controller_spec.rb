require 'rails_helper'

RSpec.describe EmailAddressesController, type: :controller do


  let(:valid_attributes) {
    { address: "MyString", contact_id: 1, contact_type: "Person" }
  }

  let(:invalid_attributes) {
    { address: nil, contact_id: nil, contact_type: nil }
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all email_addresses as @email_addresses" do
      email_address = EmailAddress.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:email_addresses)).to eq([email_address])
    end
  end

  describe "GET #show" do
    it "assigns the requested email_address as @email_address" do
      email_address = EmailAddress.create! valid_attributes
      get :show, {:id => email_address.to_param}, valid_session
      expect(assigns(:email_address)).to eq(email_address)
    end
  end

  describe "GET #new" do
    it "assigns a new email_address as @email_address" do
      get :new, {}, valid_session
      expect(assigns(:email_address)).to be_a_new(EmailAddress)
    end
  end

  describe "GET #edit" do
    it "assigns the requested email_address as @email_address" do
      email_address = EmailAddress.create! valid_attributes
      get :edit, {:id => email_address.to_param}, valid_session
      expect(assigns(:email_address)).to eq(email_address)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:alice) { Person.create(first_name: 'Alice', last_name: 'Smith') }
      let(:valid_attributes) { {address: 'alice@thisisalice.com', contact_id: alice.id, contact_type: "Person"} }

      it "creates a new EmailAddress" do
        expect {
          post :create, {:email_address => valid_attributes}, valid_session
        }.to change(EmailAddress, :count).by(1)
      end

      it "assigns a newly created email_address as @email_address" do
        post :create, {:email_address => valid_attributes}, valid_session
        expect(assigns(:email_address)).to be_a(EmailAddress)
        expect(assigns(:email_address)).to be_persisted
      end

      it "redirects to the created email_address's person" do
        alice = Person.create(first_name: 'Alice', last_name: 'Smith')
        valid_attributes = {address: 'aliceinwonderland@gmail.com', contact_id: alice.id, contact_type: "Person"}
        post :create, {:email_address => valid_attributes}, valid_session
        expect(response).to redirect_to(alice)

        # post :create, {:email_address => valid_attributes}, valid_session
        # expect(response).to redirect_to(EmailAddress.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved email_address as @email_address" do
        post :create, {:email_address => invalid_attributes}, valid_session
        expect(assigns(:email_address)).to be_a_new(EmailAddress)
      end

      it "re-renders the 'new' template" do
        post :create, {:email_address => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do

      let(:bob) { Person.create(first_name: 'Bob', last_name: 'Jones') }
      let(:valid_attributes) { {address: 'awesome@awesome.com', contact_id: bob.id, contact_type: "Person"} }
      let(:new_attributes) { {address: 'MyNewString', contact_id: bob.id, contact_type: "Person"} }

      # let(:new_attributes) {
      #   skip("Add a hash of attributes valid for your model")
      # }

      it "updates the requested email_address" do
        email_address = EmailAddress.create! valid_attributes
        put :update, {:id => email_address.to_param, :email_address => new_attributes}, valid_session
        email_address.reload
        expect(email_address.address).to eq('MyNewString')
        expect(email_address.contact_id).to eq(1)

        # email_address = EmailAddress.create! valid_attributes
        # put :update, {:id => email_address.to_param, :email_address => new_attributes}, valid_session
        # email_address.reload
        # skip("Add assertions for updated state")
      end

      it "assigns the requested email_address as @email_address" do
        email_address = EmailAddress.create! valid_attributes
        put :update, {:id => email_address.to_param, :email_address => valid_attributes}, valid_session
        expect(assigns(:email_address)).to eq(email_address)
      end

      it "redirects to the email_address" do
        bob = Person.create(first_name: 'Bob', last_name: 'Jones')
        valid_attributes = {address: 'bob@bobtastic.com', contact_id: bob.id, contact_type: "Person"}
        email_address = EmailAddress.create! valid_attributes
        put :update, {:id => email_address.to_param, :email_address => valid_attributes}, valid_session
        expect(response).to redirect_to(bob)
      end
        # email_address = EmailAddress.create! valid_attributes
        # put :update, {:id => email_address.to_param, :email_address => valid_attributes}, valid_session
        # expect(response).to redirect_to(email_address)
    end

    context "with invalid params" do
      it "assigns the email_address as @email_address" do
        email_address = EmailAddress.create! valid_attributes
        put :update, {:id => email_address.to_param, :email_address => invalid_attributes}, valid_session
        expect(assigns(:email_address)).to eq(email_address)
      end

      it "re-renders the 'edit' template" do
        email_address = EmailAddress.create! valid_attributes
        put :update, {:id => email_address.to_param, :email_address => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested email_address" do
      email_address = EmailAddress.create! valid_attributes
      expect {
        delete :destroy, {:id => email_address.to_param}, valid_session
      }.to change(EmailAddress, :count).by(-1)
    end

    it "redirects to the email_addresses list" do
      email_address = EmailAddress.create! valid_attributes
      delete :destroy, {:id => email_address.to_param}, valid_session
      expect(response).to redirect_to(email_addresses_url)
    end
  end

end
