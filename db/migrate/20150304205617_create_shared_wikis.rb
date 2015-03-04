class CreateSharedWikis < ActiveRecord::Migration
  def change
    create_table :shared_wikis do |t|
      t.string :title
      t.string :description
      t.string :body
      t.references :collaborator, index: true

      t.timestamps
    end
  end
end
