require 'spec_helper'

describe ProjectFilesController do
  describe "GET show" do
    it "assigns the requested files as @project_file" do
      project_file = FactoryGirl.create(:project_file)
      get :show, {:id => project_file.to_param}, {}
      assigns(:project_file).should eq(project_file)
    end
  end
end
