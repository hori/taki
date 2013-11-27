describe FilesController do
  def valid_attributes
    { status: "upload",
      attachment_file_name: 'style.css',
      attachment_content_type: 'text/css',
      attachment_file_size: 10,
      attachment_updated_at: '2011-07-13 14:53:38'
    }
  end

  def valid_session
    {}
  end

  describe "GET show" do
    it "assigns the requested files as @file" do
      file = ProjectFile.create! valid_attributes
      get :show, {:id => file.to_param}, valid_session
      assigns(:file).should eq(file)
    end
  end
end
