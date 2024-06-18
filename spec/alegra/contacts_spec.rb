# frozen_string_literal: true

require 'spec_helper'

describe Alegra::Contacts do
  context 'Contacts' do
    before :each do
      @params = {
        username: 'ejemplo@ejemplo.com',
        apikey: '066b3ab09e72d4548e88'
      }
    end

    it 'should get all contacts' do
      VCR.use_cassette('list_of_contacts') do
        client = Alegra::Client.new(@params[:username], @params[:apikey])
        contacts = client.contacts.list
        expect(contacts.class).to eq Array
        expect(contacts.count).to eq 30
      end
    end

    it 'should call a specific contact' do
      VCR.use_cassette('simple_contact') do
        expected_response = {:id=>"1",
                             :name=>"A. Sara Osa",
                             :identification=>"98277222",
                             :email=>"andres+test@quincena.me",
                             :phone_primary=>"3002675430",
                             :phone_secondary=>nil,
                             :fax=>nil,
                             :mobile=>nil,
                             :observations=>nil,
                             :status=>"active",
                             :kind_of_person=>"",
                             :regime=>"SIMPLIFIED_REGIME",
                             :identification_object=>{:type=>nil, :number=>"98277222"},
                             :fiscal_residence=>"RESIDENT",
                             :enable_health_sector=>false,
                             :health_patients=>nil,
                             :address=>{:address=>"Calle 6 sur # 43 C 33", :city=>"Medellin", :department=>nil, :country=>nil, :zip_code=>nil},
                             :type=>["provider"],
                             :seller=>nil,
                             :term=>nil,
                             :price_list=>nil,
                             :internal_contacts=>[],
                             :settings=>{:send_electronic_documents=>false},
                             :statement_attached=>false,
                             :accounting=>
                               {:account_receivable=>
                                  {:id=>"5039",
                                   :id_parent=>"5038",
                                   :name=>"Cuentas por cobrar",
                                   :text=>"Cuentas por cobrar",
                                   :code=>nil,
                                   :description=>nil,
                                   :type=>"asset",
                                   :read_only=>false,
                                   :nature=>"debit",
                                   :blocked=>"no",
                                   :status=>"active",
                                   :category_rule=>{:id=>"5", :name=>"Cuentas por cobrar", :key=>"RECEIVABLE_ACCOUNTS"},
                                   :use=>"movement",
                                   :show_third_party_balance=>true},
                                :debt_to_pay=>
                                  {:id=>"5047",
                                   :id_parent=>"5046",
                                   :name=>"Cuentas por pagar - proveedores",
                                   :text=>"Cuentas por pagar - proveedores",
                                   :code=>nil,
                                   :description=>"Bajo esta categoría se encuentran los pasivos principales",
                                   :type=>"liability",
                                   :read_only=>false,
                                   :nature=>"credit",
                                   :blocked=>"no",
                                   :status=>"active",
                                   :category_rule=>{:id=>"11", :name=>"Cuentas por pagar - proveedores", :key=>"DEBTS_TO_PAY_PROVIDERS"},
                                   :use=>"movement",
                                   :show_third_party_balance=>true}}}

        client = Alegra::Client.new(@params[:username], @params[:apikey])
        contact = client.contacts.find(1)
        expect(contact.class).to eq Hash
        expect(contact).to eq expected_response
      end
    end

    it 'should create a basic contact' do
      VCR.use_cassette('create_contact') do
        expected_response = {:id=>"921",
                             :name=>"Alan Britho",
                             :identification=>"",
                             :email=>nil,
                             :phone_primary=>nil,
                             :phone_secondary=>nil,
                             :fax=>nil,
                             :mobile=>nil,
                             :observations=>nil,
                             :status=>"active",
                             :kind_of_person=>"",
                             :regime=>"",
                             :identification_object=>{:type=>nil, :number=>""},
                             :enable_health_sector=>false,
                             :health_patients=>nil,
                             :address=>{:address=>nil, :city=>nil, :department=>nil, :country=>nil, :zip_code=>nil},
                             :type=>[],
                             :seller=>nil,
                             :term=>nil,
                             :price_list=>nil,
                             :internal_contacts=>[],
                             :settings=>{:send_electronic_documents=>false},
                             :statement_attached=>false,
                             :accounting=>
                               {:account_receivable=>
                                  {:id=>"5039",
                                   :id_parent=>"5038",
                                   :name=>"Cuentas por cobrar",
                                   :text=>"Cuentas por cobrar",
                                   :code=>nil,
                                   :description=>nil,
                                   :type=>"asset",
                                   :read_only=>false,
                                   :nature=>"debit",
                                   :blocked=>"no",
                                   :status=>"active",
                                   :category_rule=>{:id=>"5", :name=>"Cuentas por cobrar", :key=>"RECEIVABLE_ACCOUNTS"},
                                   :use=>"movement",
                                   :show_third_party_balance=>true},
                                :debt_to_pay=>
                                  {:id=>"5047",
                                   :id_parent=>"5046",
                                   :name=>"Cuentas por pagar - proveedores",
                                   :text=>"Cuentas por pagar - proveedores",
                                   :code=>nil,
                                   :description=>"Bajo esta categoría se encuentran los pasivos principales",
                                   :type=>"liability",
                                   :read_only=>false,
                                   :nature=>"credit",
                                   :blocked=>"no",
                                   :status=>"active",
                                   :category_rule=>{:id=>"11", :name=>"Cuentas por pagar - proveedores", :key=>"DEBTS_TO_PAY_PROVIDERS"},
                                   :use=>"movement",
                                   :show_third_party_balance=>true}}}

        _params = {
          name: 'Alan Britho'
        }
        client = Alegra::Client.new(@params[:username], @params[:apikey])
        contact = client.contacts.create(_params)
        expect(contact.class).to eq Hash
        expect(contact).to eq(expected_response)
      end
    end

    it 'should create a completed contact' do
      VCR.use_cassette('create_completed_contact') do
        expected_response = {:id=>"921",
                             :name=>"Armando Casas",
                             :identification=>"963.654.988",
                             :email=>"armando.casas@alegra.com",
                             :phone_primary=>"111 11 11",
                             :phone_secondary=>nil,
                             :fax=>nil,
                             :mobile=>nil,
                             :observations=>nil,
                             :status=>"active",
                             :kind_of_person=>"",
                             :regime=>"",
                             :identification_object=>{:type=>nil, :number=>"963.654.988"},
                             :enable_health_sector=>false,
                             :health_patients=>nil,
                             :address=>{:address=>"Avenida Madison", :city=>"New York, USA", :department=>nil, :country=>nil, :zip_code=>nil},
                             :type=>["client"],
                             :seller=>nil,
                             :term=>{:id=>2, :name=>"8 días", :days=>"8"},
                             :price_list=>nil,
                             :internal_contacts=>[{:id=>"2009891", :id_local=>"2", :name=>"Lina", :last_name=>"Montoya", :email=>"prueba4@alegra.com", :phone=>"123 45 67 ext 25", :mobile=>"(333) 333 33 33", :send_notifications=>false}],
                             :settings=>{:send_electronic_documents=>false},
                             :statement_attached=>false,
                             :accounting=>
                               {:account_receivable=>
                                  {:id=>"5039",
                                   :id_parent=>"5038",
                                   :name=>"Cuentas por cobrar",
                                   :text=>"Cuentas por cobrar",
                                   :code=>nil,
                                   :description=>nil,
                                   :type=>"asset",
                                   :read_only=>false,
                                   :nature=>"debit",
                                   :blocked=>"no",
                                   :status=>"active",
                                   :category_rule=>{:id=>"5", :name=>"Cuentas por cobrar", :key=>"RECEIVABLE_ACCOUNTS"},
                                   :use=>"movement",
                                   :show_third_party_balance=>true},
                                :debt_to_pay=>
                                  {:id=>"5047",
                                   :id_parent=>"5046",
                                   :name=>"Cuentas por pagar - proveedores",
                                   :text=>"Cuentas por pagar - proveedores",
                                   :code=>nil,
                                   :description=>"Bajo esta categoría se encuentran los pasivos principales",
                                   :type=>"liability",
                                   :read_only=>false,
                                   :nature=>"credit",
                                   :blocked=>"no",
                                   :status=>"active",
                                   :category_rule=>{:id=>"11", :name=>"Cuentas por pagar - proveedores", :key=>"DEBTS_TO_PAY_PROVIDERS"},
                                   :use=>"movement",
                                   :show_third_party_balance=>true}}}

        _params = {
          name: 'Armando Casas',
          identification: '963.654.988',
          email: 'armando.casas@alegra.com',
          phone_primary: '111 11 11',
          term:
                        {
                          id: 2
                        },
          type: ['client'],
          address: {
            address: 'Avenida Madison',
            city: 'New York, USA'
          },
          internal_contacts: [
            {
              name: 'Lina',
              last_name: 'Montoya',
              email: 'prueba4@alegra.com',
              phone: '123 45 67 ext 25',
              mobile: '(333) 333 33 33',
              send_notifications: 'no'
            }
          ]
        }
        client = Alegra::Client.new(@params[:username], @params[:apikey])
        contact = client.contacts.create(_params)
        expect(contact.class).to eq Hash
        expect(contact).to eq(expected_response)
      end
    end

    it 'should update a contact' do
      VCR.use_cassette('update_completed_contact') do
        expected_response = {:id=>"1",
                             :name=>"A. Sara Osa",
                             :identification=>"98277222",
                             :email=>"andres+test@quincena.me",
                             :phone_primary=>"3002675430",
                             :phone_secondary=>nil,
                             :fax=>nil,
                             :mobile=>nil,
                             :observations=>nil,
                             :status=>"active",
                             :kind_of_person=>"",
                             :regime=>"SIMPLIFIED_REGIME",
                             :identification_object=>{:type=>nil, :number=>"98277222"},
                             :fiscal_residence=>"RESIDENT",
                             :enable_health_sector=>false,
                             :health_patients=>nil,
                             :address=>{:address=>"Calle 6 sur # 43 C 33", :city=>"Medellin", :department=>nil, :country=>nil, :zip_code=>nil},
                             :type=>["provider"],
                             :seller=>nil,
                             :term=>nil,
                             :price_list=>nil,
                             :internal_contacts=>[],
                             :settings=>{:send_electronic_documents=>false},
                             :statement_attached=>false,
                             :accounting=>
                               {:account_receivable=>
                                  {:id=>"5039",
                                   :id_parent=>"5038",
                                   :name=>"Cuentas por cobrar",
                                   :text=>"Cuentas por cobrar",
                                   :code=>nil,
                                   :description=>nil,
                                   :type=>"asset",
                                   :read_only=>false,
                                   :nature=>"debit",
                                   :blocked=>"no",
                                   :status=>"active",
                                   :category_rule=>{:id=>"5", :name=>"Cuentas por cobrar", :key=>"RECEIVABLE_ACCOUNTS"},
                                   :use=>"movement",
                                   :show_third_party_balance=>true},
                                :debt_to_pay=>
                                  {:id=>"5047",
                                   :id_parent=>"5046",
                                   :name=>"Cuentas por pagar - proveedores",
                                   :text=>"Cuentas por pagar - proveedores",
                                   :code=>nil,
                                   :description=>"Bajo esta categoría se encuentran los pasivos principales",
                                   :type=>"liability",
                                   :read_only=>false,
                                   :nature=>"credit",
                                   :blocked=>"no",
                                   :status=>"active",
                                   :category_rule=>{:id=>"11", :name=>"Cuentas por pagar - proveedores", :key=>"DEBTS_TO_PAY_PROVIDERS"},
                                   :use=>"movement",
                                   :show_third_party_balance=>true}}}

        _params = { name: 'A. Sara Osa' }
        client = Alegra::Client.new(@params[:username], @params[:apikey])
        contact = client.contacts.update(1, _params)
        expect(contact.class).to eq Hash
        expect(contact).to eq(expected_response)
      end
    end

    it 'should delete a contact' do
      VCR.use_cassette('delete_contact') do
        client = Alegra::Client.new(@params[:username], @params[:apikey])
        contact = client.contacts.delete(654)
        expect(contact.class).to eq Hash
        expect(contact).to eq(code: 200, message: 'El contacto fue eliminado correctamente.')
      end
    end
  end
end
