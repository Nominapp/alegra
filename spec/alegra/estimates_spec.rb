# frozen_string_literal: true

require 'spec_helper'

describe Alegra::Estimates do
  context 'Estimates' do
    before :each do
      @params = {
        username: 'ejemplo@ejemplo.com',
        apikey: '066b3ab09e72d4548e88'
      }
    end

    it 'should retieve an estimate' do
      VCR.use_cassette('simple_estimate') do
        client = Alegra::Client.new(@params[:username], @params[:apikey])
        estimate = client.estimates.find(2)
        expect(estimate.class).to eq Hash
        expect(estimate).to include(simple_estimate_response)
      end
    end

    it 'should create a simple estimate' do
      VCR.use_cassette('create_simple_estimate') do
        _params = {
          date: '2016-10-12',
          dueDate: '2016-10-12',
          client: 110,
          items: [
            {
              id: 17,
              price: 7_900,
              quantity: 5,
              description: 'Company test one'
            },
            {
              id: 5,
              description: 'Company test two',
              price: 299_900,
              discount: 10,
              quantity: 1
            }
          ]
        }
        client = Alegra::Client.new(@params[:username], @params[:apikey])
        estimate = client.estimates.create(_params)
        expect(estimate.class).to eq Hash
        expect(estimate).to include(create_estimate_response)
      end
    end

    it 'should send an estimate by email' do
      VCR.use_cassette('send_email_estimate_response') do
        _params = {
          emails: ['test@alegra.com']
        }
        client = Alegra::Client.new(@params[:username], @params[:apikey])
        estimate = client.estimates.send_by_email(2, _params)
        expect(estimate.class).to eq Hash
        expect(estimate).to include(code: 200, message: 'La cotización fue enviada exitosamente')
      end
    end
  end
end
