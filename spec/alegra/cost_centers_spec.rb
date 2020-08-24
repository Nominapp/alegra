# frozen_string_literal: true

require 'spec_helper'

describe Alegra::CostCenters do
  context 'CostCenters' do
    before :each do
      @params = {
        username: 'ejemplo@ejemplo.com',
        apikey: '066b3ab09e72d4548e88'
      }
      @client = Alegra::Client.new(@params[:username], @params[:apikey])
    end

    it 'should list all cost centers' do
      VCR.use_cassette('cost_centers') do
        expected_response = [{ code: '25944',
                               name: 'administrativo',
                               description: '',
                               status: 'active',
                               id: '1' }]

        cost_centers = @client.cost_centers.list
        expect(cost_centers.class).to eq Array
        expect(cost_centers).to eq expected_response
      end
    end

    it 'should get a specific cost_centers' do
      VCR.use_cassette('simple_cost_center') do
        expected_response = { code: '25944',
                              name: 'administrativo',
                              description: '',
                              status: 'active',
                              id: '1' }
        cost_center = @client.cost_centers.find(1)
        expect(cost_center.class).to eq Hash
        expect(cost_center).to eq(expected_response)
      end
    end
  end
end
