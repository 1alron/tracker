require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe 'GET #index' do
    it 'returns a 200 status code' do
      get :index
      expect(response).to have_http_status(:ok)
    end
    it 'returns an array body' do
      get :index
      expect(JSON.parse(response.body)).to be_instance_of(Array)
    end
    it 'returns task attributes' do
      get :index
      tasks = JSON.parse(response.body)
      expect(tasks[0].keys).to include('id', 'title', 'description')
    end
  end
end
