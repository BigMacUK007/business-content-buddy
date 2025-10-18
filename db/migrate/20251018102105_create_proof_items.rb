class CreateProofItems < ActiveRecord::Migration[8.0]
  def change
    create_table :proof_items do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :proof_type
      t.string :value
      t.string :attachment_url

      t.timestamps
    end
  end
end
