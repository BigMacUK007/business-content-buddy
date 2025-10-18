class CreateJournalEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :journal_entries do |t|
      t.references :user, null: false, foreign_key: true
      t.text :content
      t.string :audio_url
      t.text :transcription
      t.string :entry_type

      t.timestamps
    end
  end
end
