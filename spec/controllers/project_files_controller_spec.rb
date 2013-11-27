require 'spec_helper'

describe ProjectFilesController do
  def valid_session
    {}
  end

  describe "GET show" do
    it "assigns the requested files as @project_file" do
      project_file = FactoryGirl.create(:project_file)
      get :show, {:id => project_file.to_param}, valid_session
      assigns(:project_file).should eq(project_file)
    end
  end
end
