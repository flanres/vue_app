require 'rails_helper'

RSpec.describe Api::TasksController, type: :request do
  describe "GET tasks" do
    let(:create_task) { create(:task) }

    it "returns http success" do
      get '/api/tasks'
      expect(response).to have_http_status(:success)
    end

    it "returns Json data" do
      create_task
      get '/api/tasks'
      json = JSON.parse(response.body)
      expect(Task.count).to eq json.count
    end
  end

  xdescribe "POST tasks" do
    let(:attributes_for_task) { attributes_for(:task) }

    it "returns http success" do
      post '/api/tasks', { "task" => { "name" => "test2" } }
      expect(response.status).to eq 201
    end

    it "returns Json data" do
      post '/api/tasks', task: attributes_for_task, name: attributes_for_task[:name],
                         is_done: attributes_for_task[:is_done]
      json = JSON.parse(response.body)
      expect(attributes_for_task[:name]).to eq json['name']
    end
  end
end
