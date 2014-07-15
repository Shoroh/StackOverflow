shared_examples_for "Commentable" do
  context 'comments' do
    it "includes comments" do
      expect(response.body).to have_json_size(5).at_path(commentable)
    end

    %w[id body created_at updated_at].each do |attr|
      it "comment object contains #{attr}" do
        expect(response.body).to be_json_eql(comments.last.send(attr.to_sym).to_json).at_path(commentable << "/0/#{attr}")
      end
    end
  end
end