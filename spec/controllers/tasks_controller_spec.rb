require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe 'GET #index' do
    before(:each) do
      create_list(:task, 5)
    end
    after(:all) do
      Task.destroy_all
    end

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
    it 'filter by name' do
      get :index, params: { status: 'new' }
      expect(JSON.parse(response.body).count).to eq(5)
    end
    it 'correct answer format by header' do
      get :index
      expect(response.content_type).to include('application/json')
    end
    it 'correct answer charset' do
      get :index
      expect(response.content_type).to include('charset=utf-8')
    end
  end

  describe 'GET #show' do
    before(:each) do
      create(:task)
    end
    after(:each) do
      Task.destroy_all
    end

    it 'returns 404 status code if task not found' do
      get :show, params: { id: 0 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST #create" do
    it 'creates task' do
      post :create, params: test_task_params
      expect(Task.first).to have_attributes(title: "test_title")
    end
    it 'returns task attributes' do
      post :create, params: test_task_params
      expect(JSON.parse(response.body).keys).to include('id', 'title', 'description', 'status', 'exec_date')
    end
  end
end

def test_task_params
  {
    task: {
          title: "test_title",
          description: "test description",
          status: "new",
          exec_date: Date.tomorrow
        }
  }
end
