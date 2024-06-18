# frozen_string_literal: true

require 'spec_helper'

describe Alegra::Company do
  context 'Company' do
    before :each do
      @params = {
        username: 'ejemplo@ejemplo.com',
        apikey: '066b3ab09e72d4548e88'
      }
      @client = Alegra::Client.new(@params[:username], @params[:apikey])
    end

    it 'should get the company information' do
      VCR.use_cassette('company') do
        expected_response = {:name=>"Pruebas API Nominapp",
                             :identification=>"31231231231",
                             :phone=>"1111111111",
                             :website=>"nominapp.com",
                             :email=>"pruebas@nominapp.com",
                             :regime=>"Responsable de IVA",
                             :application_version=>"colombia",
                             :registry_date=>"2017-02-08 09:54:22",
                             :timezone=>"America/Bogota",
                             :profile=>nil,
                             :decimal_precision=>"2",
                             :calculation_scale=>"2",
                             :multitax=>false,
                             :employees_number=>nil,
                             :sector=>nil,
                             :show_invoice_total_in_words=>"no",
                             :show_retention_invoice=>"no",
                             :show_new_line_char_on_pdf=>"no",
                             :show_item_reference_on_pdf=>false,
                             :additional_charges_active=>true,
                             :is_active_no_iva_day=>false,
                             :show_no_iva_days_on_items=>nil,
                             :legal_representative=>nil,
                             :address=>{:city=>"Medellín", :department=>"Antioquia", :address=>"cassdfsdfds", :zip_code=>""},
                             :currency=>{:code=>"COP", :symbol=>"$"},
                             :multicurrency=>false,
                             :decimal_separator=>",",
                             :invoice_preferences=>
                               {:default_anotation=>"",
                                :default_terms_and_conditions=>
                                  "Esta factura se asimila en todos sus efectos a una letra de cambio de conformidad con el Art. 774 del código de comercio. Autorizo que en caso de incumplimiento de esta obligación sea reportado a las centrales de riesgo, se cobraran intereses por mora."},
                             :logo=>nil,
                             :kind_of_person=>"LEGAL_ENTITY",
                             :identification_object=>{:type=>"NIT", :number=>"31231231231", :dv=>"7", :nationality_kind_of_person=>nil},
                             :settings=>
                               {:can_stamp_invoices=>false,
                                :electronic_invoicing=>false,
                                :is_types_and_numerations_feature_enabled=>true,
                                :electronic_invoicing_wizard_step=>nil,
                                :electronic_invoicing_wizard_progress=>"unstarted",
                                :has_seen_faj43b=>false,
                                :can_create_aiu_invoice=>nil,
                                :can_create_health_sector_invoice=>nil,
                                :show_sale_tickets=>true,
                                :health_provider_code=>nil,
                                :next_number_event_for_documents_received=>nil,
                                :next_number_event_for_documents_received_prefix=>nil,
                                :electronic_response=>false,
                                :is_active_automation_electronic_invoice=>false,
                                :is_active_electronic_sale_tickets=>false,
                                :automation_electronic_invoice_id_resolution=>nil,
                                :can_create_export_invoice=>nil}}

        company = @client.company.find
        expect(company.class).to eq Hash
        expect(company).to eq expected_response
      end
    end

    it 'should update the company' do
      VCR.use_cassette('update_completed_company') do
        expected_response = {:name=>"Pruebas API Nominapp",
                             :identification=>"31231231231",
                             :phone=>"1111111111",
                             :website=>"nominapp.com",
                             :email=>"pruebas@nominapp.com",
                             :regime=>"Responsable de IVA",
                             :application_version=>"colombia",
                             :registry_date=>"2017-02-08 09:54:22",
                             :timezone=>"America/Bogota",
                             :profile=>nil,
                             :decimal_precision=>"2",
                             :calculation_scale=>"2",
                             :multitax=>false,
                             :employees_number=>nil,
                             :sector=>nil,
                             :show_invoice_total_in_words=>"no",
                             :show_retention_invoice=>"no",
                             :show_new_line_char_on_pdf=>"no",
                             :show_item_reference_on_pdf=>false,
                             :additional_charges_active=>true,
                             :is_active_no_iva_day=>false,
                             :show_no_iva_days_on_items=>nil,
                             :legal_representative=>nil,
                             :address=>{:city=>"Medellín", :department=>"Antioquia", :address=>"cassdfsdfds", :zip_code=>""},
                             :currency=>{:code=>"COP", :symbol=>"$"},
                             :multicurrency=>false,
                             :decimal_separator=>",",
                             :invoice_preferences=>
                               {:default_anotation=>"",
                                :default_terms_and_conditions=>
                                  "Esta factura se asimila en todos sus efectos a una letra de cambio de conformidad con el Art. 774 del código de comercio. Autorizo que en caso de incumplimiento de esta obligación sea reportado a las centrales de riesgo, se cobraran intereses por mora."},
                             :logo=>nil,
                             :kind_of_person=>"LEGAL_ENTITY",
                             :identification_object=>{:type=>"NIT", :number=>"31231231231", :dv=>"7", :nationality_kind_of_person=>nil},
                             :settings=>
                               {:can_stamp_invoices=>false,
                                :electronic_invoicing=>false,
                                :is_types_and_numerations_feature_enabled=>true,
                                :electronic_invoicing_wizard_step=>nil,
                                :electronic_invoicing_wizard_progress=>"unstarted",
                                :has_seen_faj43b=>false,
                                :can_create_aiu_invoice=>nil,
                                :can_create_health_sector_invoice=>nil,
                                :show_sale_tickets=>true,
                                :health_provider_code=>nil,
                                :next_number_event_for_documents_received=>nil,
                                :next_number_event_for_documents_received_prefix=>nil,
                                :electronic_response=>false,
                                :is_active_automation_electronic_invoice=>false,
                                :is_active_electronic_sale_tickets=>false,
                                :automation_electronic_invoice_id_resolution=>nil,
                                :can_create_export_invoice=>nil}}

        params = { website: 'nominapp.com' }
        company = @client.company.update(params)
        expect(company.class).to eq Hash
        expect(company).to eq(expected_response)
      end
    end
  end
end
